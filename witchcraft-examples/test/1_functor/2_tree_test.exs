defmodule Seminar.Functor.TreeTest do
  use ExUnit.Case

  alias Witchcraft.Functor
  alias TypeClass.Property.Generator
  alias Example.Tree

  import Witchcraft.Functor

  test "new is generated" do
    assert Tree.new(1) == %Tree{data: 1}
    assert Tree.new(1, nil, Tree.new(2)) == %Tree{data: 1, right: %Tree{data: 2}}
  end

  describe "Functor property" do
    # Just to explain.
    # These properties are automatically checked during compile by `definst`.
    test "identity" do
      # `Generator` protocol is used to generate sample data.
      wrapped = Generator.generate(%Tree{})

      assert wrapped |> Functor.map(fn x -> x end) == wrapped
    end

    test "composition" do
      wrapped = Generator.generate(%Tree{})

      double = fn x -> x * 2 end
      succ = fn x -> x + 1 end

      assert wrapped
             |> Functor.map(double)
             |> Functor.map(succ) ==
               wrapped
               |> Functor.map(fn x -> x |> double.() |> succ.() end)
    end
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
