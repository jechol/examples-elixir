// Erlang array
// https://erlang.org/doc/man/array.html
pub external type FixedArray(a)
// No constructor.

pub type ArrayError {
  IndexOutOfRange
}

pub external fn new(size: Int) -> FixedArray(a) =
  "m22_call_erlang_from_gleam" "new"

pub external fn size(array: FixedArray(a)) -> Int =
  "m22_call_erlang_from_gleam" "size"

pub external fn set(
  array: FixedArray(a),
  index: Int,
  value: a,
) -> Result(FixedArray(a), ArrayError) =
  "m22_call_erlang_from_gleam" "set"

pub external fn get(array: FixedArray(a), index: Int) -> Result(a, ArrayError) =
  "m22_call_erlang_from_gleam" "get"
