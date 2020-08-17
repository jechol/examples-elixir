import gleam/should
import m20_inter_op/m22_call_erlang_from_gleam.{
  FixedArray, IndexOutOfRange
} as array

pub fn size_test() {
  array.new(10)
  |> array.size()
  |> should.equal(10)
}

pub fn set_get_ok_test() {
  let Ok(
    arr2,
  ) = array.new(10)
    |> array.set(5, 9)

  arr2
  |> array.get(5)
  |> should.equal(Ok(9))
}

// pub fn set_compile_time_type_error() {
//   let Ok(arr) = array.new(10) |> array.set(0, 1)
//   arr |> array.set(0, "a")
// }

pub fn set_out_of_range_test() {
  array.new(10)
  |> array.set(15, 100)
  |> should.equal(Error(IndexOutOfRange))
}

pub fn get_out_of_range_test() {
  array.new(10)
  |> array.get(15)
  |> should.equal(Error(IndexOutOfRange))
}
