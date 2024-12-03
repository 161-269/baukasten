-module(backend_ffi).
-include_lib("kernel/include/file.hrl").
-export([generate_css/5, unique_int/0]).

-spec unique_int() -> non_neg_integer().
unique_int() ->
    erlang:unique_integer([monotonic, positive]).

-spec generate_css(binary(), binary(), binary(), binary(), non_neg_integer()) ->
    {ok, binary()} | {error, binary()}.
generate_css(WorkingDirectory, TailwindCliPath, ConfigPath, OutputCssPath, Timeout) ->
    Args = ["--config", ConfigPath, "--output", OutputCssPath, "--minify"],

    PortSettings = [
        {cd, WorkingDirectory},
        exit_status,
        use_stdio,
        stderr_to_stdout,
        binary,
        {args, Args}
    ],

    Port = erlang:open_port({spawn_executable, TailwindCliPath}, PortSettings),

    case erlang:port_info(Port, os_pid) of
        {os_pid, OSPid} ->
            StartTime = erlang:monotonic_time(millisecond),
            receive_output(Port, Timeout, OSPid, StartTime, []);
        _ ->
            port_close(Port),
            {error, <<"Error: Could not get OS process ID.">>}
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
