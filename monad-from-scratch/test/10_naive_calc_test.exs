defmodule NaiveCalcTest do
  use ExUnit.Case

  alias Expr.{Val, Div}

  test "success case" do
    assert Val.new(6)
           |> Div.new(Div.new(Val.new(4), Val.new(2)))
           |> NaiveCalc.eval() ==
             3
  end

  test "div by zero" do
    assert_raise ArithmeticError, fn ->
      Val.new(1)
      |> Div.new(Val.new(0))
      |> NaiveCalc.eval()
    end
  end
end
