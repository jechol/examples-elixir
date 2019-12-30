defmodule Seminar.Monad.Maybe.NaiveStackTest do
  use ExUnit.Case
  use Witchcraft

  import Seminar.Monad.Maybe.NaiveStack

  test "push" do
    assert new() |> push(1) |> push(2) == %NaiveStack{stack: [2, 1]}
  end

  test "pop" do
    assert {:ok, {2, %NaiveStack{stack: [1]}}} = %NaiveStack{stack: [2, 1]} |> pop()
    assert {:ok, {1, []}} = [1] |> pop()
    assert {:error, :empty} = [] |> pop()
  end
end
