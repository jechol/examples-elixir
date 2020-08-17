import gleam/should
import m10_syntax/s00_tree.{Nil, Tree}

pub fn sum_test() {
  let left = Tree(val: 3.0, left: Nil, right: Nil)
  let root = Tree(val: 10.0, left: left, right: Nil)

  s00_tree.sum(root)
  |> should.equal(13.0)
}
