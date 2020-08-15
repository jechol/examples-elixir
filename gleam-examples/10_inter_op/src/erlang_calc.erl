-module(erlang_calc).

-export([add/2, call_elixir_add/2, call_gleam_add/2]).

add(A, B) -> A + B.

call_elixir_add(A, B) -> 'Elixir.ElixirCalc':add(A, B).

call_gleam_add(A, B) -> gleam_calc:add(A, B).
