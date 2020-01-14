defmodule MaybeBindCalc do
  alias Expr.{Val, Div}
  alias Maybe.{Just, Nothing}

  import Bind

  defp safe_div(_, 0), do: Nothing.new()
  defp safe_div(n, m), do: Just.new(n / m)

  def eval(%Val{val: val}), do: Just.new(val)

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
