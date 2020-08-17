defmodule M00Syntax.S00TreeTest do
  use ExUnit.Case
  require M00Syntax.S00Tree
  alias M00Syntax.S00Tree, as: Tree

  test "sum/1 without record" do
    left = {:tree, 3.0, nil, nil}
    root = {:tree, 10.0, left, nil}

    assert :m10_syntax@s00_tree.sum(root) == 13.0
  end

  test "Tree.record" do
    assert Tree.tree(val: 3.0, left: nil, right: nil) == {:tree, 3.0, nil, nil}
  end

  test "sum/1 with record" do
    left = Tree.tree(val: 3.0, left: nil, right: nil)
    root = Tree.tree(val: 10.0, left: left, right: nil)

    assert :m10_syntax@s00_tree.sum(root) == 13.0
  end
end
