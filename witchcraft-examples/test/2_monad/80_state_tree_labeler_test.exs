defmodule Example.StateTreeLabelerTest do
  use ExUnit.Case
  use Witchcraft

  alias Algae.State
  alias Example.Tree
  alias Example.StateTreeLabeler, as: Labeler

  test "success cases" do
    tree = Tree.new(9, nil, Tree.new(7, Tree.new(5)))

    # Rank from 0
    {labeled_from_zero, 3} = tree |> Labeler.rank_post_order() |> State.run(0)

    assert labeled_from_zero ==
             %Tree{
               data: 2,
               right: %Tree{data: 1, left: %Tree{data: 0}}
             }

    # Rank from 10
    {labeled_from_ten, 13} = tree |> Labeler.rank_post_order() |> State.run(10)

    assert labeled_from_ten ==
             %Tree{
               data: 12,
               right: %Tree{data: 11, left: %Tree{data: 10}}
             }
  end
end
