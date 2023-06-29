defmodule UnsafeCalcTest do
  use ExUnit.Case

  alias Expr.{Val, Div}

  test "success case" do
    # 10 / (4 / 2) = 5
    assert Val.new(10)
           |> Div.new(Div.new(Val.new(4), Val.new(2)))
           |> UnsafeCalc.eval() ==
             5
  end

  test "div by zero" do
    # 1 / 0
    assert_raise ArithmeticError, fn ->
      Val.new(1)
      |> Div.new(Val.new(0))
      |> UnsafeCalc.eval()
    end
  end
end
