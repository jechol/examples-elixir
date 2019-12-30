defmodule Seminar.Functor.Maybe.RawCalculator do
  use Witchcraft

  alias Seminar.Adt.Expr.{Val, Div}

  def eval(%Val{val: val}), do: val

  def eval(%Div{num: num, denom: denom}) do
    l = eval(num)
    r = eval(denom)
    div(l, r)
  end
end
