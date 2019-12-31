defmodule Seminar.Monad.StateTreeRankerTest do
  use ExUnit.Case
  use Witchcraft

  alias Algae.State
  alias Seminar.Adt.Tree
  alias Seminar.Monad.StateTreeRanker, as: Ranker

  test "success cases" do
    tree = Tree.new(9, nil, Tree.new(7, Tree.new(5)))

    # Rank from 0
    {ranked_from_zero, 3} = tree |> Ranker.rank_post_order() |> State.run(0)

    assert ranked_from_zero ==
             %Tree{
               data: 2,
               right: %Tree{data: 1, left: %Tree{data: 0}}
             }

    # Rank from 10
    {ranked_from_ten, 13} = tree |> Ranker.rank_post_order() |> State.run(10)

    assert ranked_from_ten ==
             %Tree{
               data: 12,
               right: %Tree{data: 11, left: %Tree{data: 10}}
             }
  end
end
