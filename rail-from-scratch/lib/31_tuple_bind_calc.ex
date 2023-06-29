defmodule TupleBindCalc do
  alias Expr.{Val, Div}

  import Bind

  defp safe_div(_, 0), do: {:error, :div_by_zero}
  defp safe_div(n, m), do: {:ok, n / m}

  def eval(%Val{val: val}), do: {:ok, val}

  def eval(%Div{num: num, denom: denom}) do
    eval(num)
    |> bind(fn num_val ->
      eval(denom)
      |> bind(fn denom_val ->
        safe_div(num_val, denom_val)
      end)
    end)
  end
end
