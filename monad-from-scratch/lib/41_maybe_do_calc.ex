defmodule MaybeDoCalc do
  require DoNotation

  alias Expr.{Val, Div}
  alias Maybe.{Just, Nothing}

  defp safe_div(_, 0), do: Nothing.new()
  defp safe_div(n, m), do: Just.new(n / m)

  def eval(%Val{val: val}), do: Just.new(val)

  def eval(%Div{num: num, denom: denom}) do
    DoNotation.bind do
      num_val <- eval(num)
      denom_val <- eval(denom)
      safe_div(num_val, denom_val)
    end
  end
end
