defmodule Seminar.Functor.Maybe.RailwayCalculator do
  use Witchcraft

  alias Seminar.Adt.Expr.{Val, Div}

  def eval(%Val{val: val}), do: {:ok, val}

  def eval(%Div{num: num, denom: denom}) do
    with {:ok, num_val} <- eval(num),
         {:ok, denom_val} <- eval(denom) do
      if denom_val == 0 do
        {:error, :div_by_zero}
      else
        {:ok, num_val / denom_val}
      end
    end
  end
end
