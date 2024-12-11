-module(backend_ffi).
-include_lib("kernel/include/file.hrl").

-export([
    unique_int/0,
    spawn_executable/6,
    kill_executable/1,
    send_to_executable/2,
    set_timeout/2
]).

-type option(Type) :: {some, Type} | none.
-type error(TypeOk, TypeError) :: {ok, TypeOk} | {error, TypeError}.
-type executable() :: pid().
-type data_callback() :: fun((binary()) -> any()).
-type exit_callback() :: fun((error(non_neg_integer(), binary())) -> any()).

-spec unique_int() -> non_neg_integer().
unique_int() ->
    erlang:unique_integer([monotonic, positive]).

-spec spawn_executable(
    binary(),
    binary(),
    [binary()],
    data_callback(),
    exit_callback(),
    option(non_neg_integer())
) -> error(executable(), binary()).

spawn_executable(WorkingDirectory, ExecutablePath, Args, DataCallback, ExitCallback, Timeout) ->
    spawn_link(fun() ->
        handler(WorkingDirectory, ExecutablePath, Args, DataCallback, ExitCallback, Timeout)
    end).

-spec handler(
    binary(),
    binary(),
    [binary()],
    data_callback(),
    exit_callback(),
    option(non_neg_integer())
) -> nil.
handler(WorkingDirectory, ExecutablePath, Args, DataCallback, ExitCallback, SomeTimeout) ->
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

    Timeout =
        case SomeTimeout of
            {some, Value} -> Value;
            none -> infinity
        end,

    case erlang:port_info(Port, os_pid) of
        {os_pid, OsPid} ->
            monitor_port(Port, OsPid, DataCallback, ExitCallback, Timeout);
        undefined ->
            ExitCallback({error, <<"Failed to open port.">>})
    end,

    nil.

-spec monitor_port(
    port(), integer(), data_callback(), exit_callback(), non_neg_integer() | infinity
) -> no_return().
monitor_port(Port, OsPid, DataCallback, ExitCallback, Timeout) ->
    StartTime = erlang:system_time(millisecond),

    Timeout =
        case Timeout < 0 of
            true -> 0;
            false -> Timeout
        end,

    NewTimeout = fun() ->
        case Timeout of
            infinity -> infinity;
            _ -> Timeout - erlang:system_time(millisecond) + StartTime
        end
    end,

    receive
        {Port, {data, Data}} ->
            DataCallback(Data),
            monitor_port(Port, OsPid, DataCallback, ExitCallback, NewTimeout());
        {Port, {exit_status, Status}} ->
            ExitCallback({ok, Status});
        {send_data, Data} ->
            erlang:port_command(Port, Data),
            monitor_port(Port, OsPid, DataCallback, ExitCallback, NewTimeout());
        {kill_executable} ->
            do_kill_executable(Port, OsPid, ExitCallback, <<"Killed by the user.">>);
        {set_timeout, NextTimeoutOption} ->
            NextTimeout =
                case NextTimeoutOption of
                    {some, Value} ->
                        Value;
                    none ->
                        infinity
                end,
            monitor_port(Port, OsPid, DataCallback, ExitCallback, NextTimeout);
        _Unexpected ->
            monitor_port(Port, OsPid, DataCallback, ExitCallback, NewTimeout())
    after Timeout ->
        do_kill_executable(Port, OsPid, ExitCallback, <<"Timeout reached.">>)
    end.

-spec do_kill_executable(port(), integer(), exit_callback(), binary()) -> no_return().
do_kill_executable(Port, OsPid, ExitCallback, Reason) ->
    case os:type() of
        {unix, _} ->
            os:cmd(io_lib:format("kill -9 ~p", [OsPid]));
        {win32, _} ->
            os:cmd(io_lib:format("taskkill /PID ~p /F", [OsPid]));
        _ ->
            ok
    end,

    erlang:port_close(Port),
    ExitCallback({error, Reason}).

-spec send_to_executable(executable(), binary()) -> nil.
send_to_executable(HandlerPid, Data) ->
    HandlerPid ! {send_data, Data},
    nil.

-spec kill_executable(executable()) -> nil.
kill_executable(HandlerPid) ->
    HandlerPid ! {kill_executable},
    nil.

-spec set_timeout(executable(), option(non_neg_integer())) -> nil.
set_timeout(HandlerPid, Timeout) ->
    HandlerPid ! {set_timeout, Timeout},
    nil.
