-module(m22_call_erlang_from_gleam).

-export([get/2, new/1, set/3, size/1]).

% Reference: https://erlang.org/doc/man/array.html

new(Size) -> array:new(Size, {fixed, true}).

size(Array) -> array:size(Array).

set(Array, Index, Value) ->
    try {ok, array:set(Index, Value, Array)} catch
      error:badarg -> {error, index_out_of_range}
    end.

get(Array, Index) ->
    try {ok, array:get(Index, Array)} catch
      error:badarg -> {error, index_out_of_range}
    end.
