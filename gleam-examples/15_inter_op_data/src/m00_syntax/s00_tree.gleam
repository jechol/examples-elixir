// Module name is auto.

pub type Tree {
  // No type class. -> Should implement specifically for Float.
  Tree(val: Float, left: Tree, right: Tree)
  Nil
}

pub fn sum(tree: Tree) -> Float {
  case tree {
    Nil -> 0.0
    Tree(val: val, left: left, right: right) ->
      val +. sum(left) +. sum(right)
  }
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