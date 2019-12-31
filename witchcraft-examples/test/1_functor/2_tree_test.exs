defmodule Seminar.Functor.TreeTest do
  use ExUnit.Case

  alias Example.Tree
  import Witchcraft.Functor

  test "new" do
    assert Tree.new(1) == %Tree{data: 1}
    assert Tree.new(1, nil, Tree.new(2)) == %Tree{data: 1, right: %Tree{data: 2}}
  end

  test "~>" do
    tree =
      Tree.new(
        1,
        nil,
        Tree.new(2, Tree.new(3))
      )

    assert tree ==
             %Tree{
               data: 1,
               left: nil,
               right: %Tree{data: 2, left: %Tree{data: 3}}
             }

    assert tree ~> fn x -> x * 2 end ==
             %Tree{
               data: 2,
               left: nil,
               right: %Tree{data: 4, left: %Tree{data: 6}}
             }
  end
end
