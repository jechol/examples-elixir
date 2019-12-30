defmodule Seminar.Adt.TreeTest do
  use ExUnit.Case

  alias Seminar.Adt.Tree

  test "Tree" do
    assert Tree.new(1) == %Tree{data: 1}
    assert Tree.new(1, nil, Tree.new(2)) == %Tree{data: 1, right: %Tree{data: 2}}
  end
end
