defmodule M00Syntax.S00TreeTest do
  use ExUnit.Case
  require M00Syntax.S00Tree
  alias M00Syntax.S00Tree, as: Tree

  test "sum/1 without record" do
    left = {:tree, 3.0, :none, :none}
    root = {:tree, 10.0, {:some, left}, :none}

    assert :m00_syntax@s00_tree.sum(root) == 13.0
  end

  test "sum/1 with record" do
    left = Tree.tree(val: 3.0, left: :none, right: :none)
    root = Tree.tree(val: 10.0, left: {:some, left}, right: :none)

    assert :m00_syntax@s00_tree.sum(root) == 13.0
  end
end
