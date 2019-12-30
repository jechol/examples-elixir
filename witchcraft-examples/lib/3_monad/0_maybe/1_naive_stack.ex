defmodule Seminar.Monad.Maybe.NaiveStack do
  alias __MODULE__

  defstruct stack: []

  def new(), do: %NaiveStack{}

  def push(%NaiveStack{stack: stack}, value) do
    %NaiveStack{stack: [value | stack]}
  end

  def pop(%NaiveStack{stack: [head | tail]}), do: {:ok, {head, %NaiveStack{stack: tail}}}
  def pop(%NaiveStack{stack: []}), do: {:error, :empty}
end
