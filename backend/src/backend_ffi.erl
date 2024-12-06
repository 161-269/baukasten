-module(backend_ffi).
-include_lib("kernel/include/file.hrl").

-export([
    unique_int/0,
    spawn_executable/5,
    kill_executable/1,
    send_to_executable/2
]).

-type executable() :: pid().
-type data_callback() :: fun((binary()) -> any()).
-type exit_callback() :: fun(({ok, non_neg_integer()} | {error, binary()}) -> any()).

-spec unique_int() -> non_neg_integer().
unique_int() ->
    erlang:unique_integer([monotonic, positive]).

-spec spawn_executable(
    binary(),
    binary(),
    [binary()],
    data_callback(),
    exit_callback()
) -> {ok, executable()} | {error, binary()}.

spawn_executable(WorkingDirectory, ExecutablePath, Args, DataCallback, ExitCallback) ->
    spawn_link(fun() ->
        handler(WorkingDirectory, ExecutablePath, Args, DataCallback, ExitCallback)
    end).

-spec handler(
    binary(),
    binary(),
    [binary()],
    data_callback(),
    exit_callback()
) -> nil.
handler(WorkingDirectory, ExecutablePath, Args, DataCallback, ExitCallback) ->
    PortSettings = [
        {cd, WorkingDirectory},
        exit_status,
        use_stdio,
        stderr_to_stdout,
        in,
        binary,
        {args, Args}
    ],

    Port = erlang:open_port({spawn_executable, ExecutablePath}, PortSettings),

    case erlang:port_info(Port, os_pid) of
        {os_pid, OsPid} ->
            monitor_port(Port, OsPid, DataCallback, ExitCallback);
        undefined ->
            ExitCallback({error, <<"Failed to open port.">>})
    end,

    nil.

-spec monitor_port(port(), integer(), data_callback(), exit_callback()) -> no_return().
monitor_port(Port, OsPid, DataCallback, ExitCallback) ->
    receive
        {Port, {data, Data}} ->
            DataCallback(Data),
            monitor_port(Port, OsPid, DataCallback, ExitCallback);
        {Port, {exit_status, Status}} ->
            ExitCallback({ok, Status});
        {send_data, Data} ->
            erlang:port_command(Port, Data),
            monitor_port(Port, OsPid, DataCallback, ExitCallback);
        {kill_executable} ->
            case os:type() of
                {unix, _} ->
                    os:cmd(io_lib:format("kill -9 ~p", [OsPid]));
                {win32, _} ->
                    os:cmd(io_lib:format("taskkill /PID ~p /F", [OsPid]));
                _ ->
                    ok
            end,

            erlang:port_close(Port);
        _Unexpected ->
            monitor_port(Port, OsPid, DataCallback, ExitCallback)
    end.

-spec send_to_executable(executable(), binary()) -> nil.
send_to_executable(HandlerPid, Data) ->
    HandlerPid ! {send_data, Data},
    nil.

-spec kill_executable(executable()) -> nil.
kill_executable(HandlerPid) ->
    HandlerPid ! {kill_executable},
    nil.
