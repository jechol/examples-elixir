defmodule NaiveCalc do
  alias Expr.{Val, Div}

  def eval(%Val{val: val}), do: val

  def eval(%Div{num: num, denom: denom}) do
    eval(num) / eval(denom)
  end
end
