defmodule TupleWithCalc do
  alias Expr.{Val, Div}

  defp safe_div(_, 0), do: {:error, :div_by_zero}
  defp safe_div(n, m), do: {:ok, n / m}

  def eval(%Val{val: val}), do: {:ok, val}

  def eval(%Div{num: num, denom: denom}) do
    with {:ok, num_val} <- eval(num),
         {:ok, denom_val} <- eval(denom) do
      safe_div(num_val, denom_val)
    end
  end
end
