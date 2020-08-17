import gleam/should
import gleam/option.{Option, Some, None}
import m00_syntax/s00_tree.{Tree}

pub fn sum_test() {
  let a = Tree(val: 10.0, left: None, right: None)

  s00_tree.sum(a)
  |> should.equal(10.0)
}