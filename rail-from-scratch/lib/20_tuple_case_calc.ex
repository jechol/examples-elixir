defmodule TupleCaseCalc do
  alias Expr.{Val, Div}

  def eval(%Val{val: val}), do: {:ok, val}

  def eval(%Div{num: num, denom: denom}) do
    case eval(num) do
      {:ok, num_val} ->
        case eval(denom) do
          {:ok, denom_val} ->
            safe_div(num_val, denom_val)

          {:error, _} = e ->
            e
        end

      {:error, _} = e ->
        e
    end
  end

  defp safe_div(_, 0), do: {:error, :div_by_zero}
  defp safe_div(n, m), do: {:ok, n / m}
end
