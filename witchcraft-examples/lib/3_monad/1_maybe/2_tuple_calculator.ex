defmodule Seminar.Functor.Maybe.TupleCalculator do
  use Witchcraft

  alias Seminar.Adt.Expr.{Val, Div}

  def eval(%Val{val: val}), do: {:ok, val}

  def eval(%Div{num: num, denom: denom}) do
    case eval(num) do
      {:ok, num_val} ->
        case eval(denom) do
          {:ok, denom_val} ->
            if denom_val == 0 do
              {:error, :div_by_zero}
            else
              {:ok, num_val / denom_val}
            end

          {:error, _} = e ->
            e
        end

      {:error, _} = e ->
        e
    end
  end
end
