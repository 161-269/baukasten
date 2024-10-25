-module(backend_ffi).
-include_lib("kernel/include/file.hrl").
-export([generate_css/4, unique_int/0]).

unique_int() ->
    erlang:unique_integer([monotonic, positive]).

generate_css(TailwindCliPaths, ConfigPath, OutputCssPath, Timeout) ->
    case find_executable(TailwindCliPaths) of
        {ok, TailwindCliPath} ->
            Args = ["-c", ConfigPath, "-o", OutputCssPath, "--minify"],

            PortSettings = [
                exit_status,
                use_stdio,
                stderr_to_stdout,
                binary,
                {args, Args}
            ],

            Port = open_port({spawn_executable, TailwindCliPath}, PortSettings),

            case erlang:port_info(Port, os_pid) of
                {os_pid, OSPid} ->
                    StartTime = erlang:monotonic_time(millisecond),
                    receive_output(Port, Timeout, OSPid, StartTime, []);
                _ ->
                    port_close(Port),
                    {error, <<"Error: Could not get OS process ID.">>}
            end;
        {error, Reason} ->
            {error, Reason}
    end.

find_executable([Path | Rest]) ->
    case check_executable(Path) of
        true ->
            {ok, Path};
        false ->
            find_executable(Rest)
    end;
find_executable([]) ->
    {error, <<"Error: No executable Tailwind CSS CLI found in the provided paths.">>}.

check_executable(Path) ->
    case file:read_file_info(Path) of
        {ok, FileInfo} ->
            FileType = FileInfo#file_info.type,
            Mode = FileInfo#file_info.mode,
            Executable = is_executable(Mode),
            (FileType == regular) andalso Executable;
        _ ->
            false
    end.

is_executable(Mode) ->
    case os:type() of
        {win32, _} ->
            true;
        {unix, _} ->
            (Mode band 16) /= 0 orelse
                (Mode band 8) /= 0 orelse
                (Mode band 1) /= 0;
        _ ->
            false
    end.

receive_output(Port, Timeout, OSPid, StartTime, AccumulatedOutput) ->
    ElapsedTime = erlang:monotonic_time(millisecond) - StartTime,
    RemainingTime = Timeout - ElapsedTime,
    if
        RemainingTime =< 0 ->
            kill_process(OSPid),
            port_close(Port),
            Output = iolist_to_binary(AccumulatedOutput),
            {error, <<"Error: Process timed out: ">> ++ Output};
        true ->
            receive
                {Port, {data, Data}} ->
                    receive_output(Port, Timeout, OSPid, StartTime, [AccumulatedOutput, Data]);
                {Port, {exit_status, Status}} ->
                    Output = iolist_to_binary(AccumulatedOutput),
                    Success = (Status =:= 0),
                    {
                        case Success of
                            true -> ok;
                            false -> error
                        end,
                        Output
                    }
            after RemainingTime ->
                kill_process(OSPid),
                port_close(Port),
                Output = iolist_to_binary(AccumulatedOutput),
                {error, <<"Error: Process timed out: ">> ++ Output}
            end
    end.

kill_process(OSPid) ->
    case os:type() of
        {unix, _} ->
            os:cmd(io_lib:format("kill -9 ~p", [OSPid]));
        {win32, _} ->
            os:cmd(io_lib:format("taskkill /PID ~p /F", [OSPid]));
        _ ->
            ok
    end.
