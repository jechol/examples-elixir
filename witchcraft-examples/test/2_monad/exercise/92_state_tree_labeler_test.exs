defmodule Example.StateTreeLabelerTest do
  use ExUnit.Case
  use Witchcraft

  alias Algae.State
  alias Example.Tree
  alias Example.StateTreeLabeler, as: Labeler

  @moduletag :exercise

  test "success cases" do
    tree = Tree.new(:a, Tree.new(:b), Tree.new(:c, Tree.new(:d), Tree.new(:e)))

    # label from 0
    {labeled_from_zero, 5} = tree |> Labeler.label_post_order() |> State.run(0)

    assert labeled_from_zero ==
             %Tree{
               data: 4,
               left: %Tree{data: 0},
               right: %Tree{left: %Tree{data: 1}, right: %Tree{data: 2}, data: 3}
             }

    # label from 10
    {labeled_from_ten, 15} = tree |> Labeler.label_post_order() |> State.run(10)

    assert labeled_from_ten ==
             %Tree{
               data: 14,
               left: %Tree{data: 10},
               right: %Tree{left: %Tree{data: 11}, right: %Tree{data: 12}, data: 13}
             }
  end
end
