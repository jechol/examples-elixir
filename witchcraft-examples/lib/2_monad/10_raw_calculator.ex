defmodule Example.RawCalculator do
  use Witchcraft

  alias Example.Expr.{Val, Div}

  def eval(%Val{val: val}), do: val

  def eval(%Div{num: num, denom: denom}) do
    # Crash if denom = 0
    l = eval(num)
    r = eval(denom)
    l / r
  end
end
