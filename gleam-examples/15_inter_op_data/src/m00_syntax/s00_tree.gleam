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

  // Try to use this method with
  // $ mix release
  // $ _build/.. start_iex
}