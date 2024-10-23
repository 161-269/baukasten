-module(widgets_ffi).
-export([counter/0]).

counter() ->
    erlang:unique_integer([monotonic, positive]).
