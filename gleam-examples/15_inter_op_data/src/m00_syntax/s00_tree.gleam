// Module name is auto.
import gleam/option.{Option, Some, None}

pub type Tree {
  // No type class. -> Should implement specifically for Float.
  Tree(val: Float, left: Option(Tree), right: Option(Tree))
}

pub fn sum(tree: Tree) {
  // Destructuring.
  let Tree(val: val, left: left, right: right) = tree

  // case is only flow-control syntax. No if, etc.
  let left_sum = case left {
    Some(tree) -> sum(tree)
    None -> 0.0
  }
  let right_sum = case right {
    Some(tree) -> sum(tree)
    None -> 0.0
  }

  // +.
  val +. left_sum +. right_sum
}

// Note 1.
// Inter-op via iex
//
// $ mix release
// $ _build/.. start_iex
// iex> :m00_syntax@s00_tree.sum({:tree, 10.0, {:some, {:tree, 3.0, :none, :none}}, :none})

// Note 2.
// Inter-op gleam type <-> Elixir record
//
// See s00_tree.ex, s00_tree_test.exs