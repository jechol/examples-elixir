defmodule Example.TupleCaseCalcTest do
  use ExUnit.Case
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Example.TupleCaseCalc, as: Calc

  test "success cases" do
    assert Val.new(2) |> Calc.eval() == {:ok, 2}

    assert Div.new(
             Val.new(4),
             Val.new(2)
           )
           |> Calc.eval() == {:ok, 2}

    assert Div.new(
             Val.new(10),
             Div.new(Val.new(4), Val.new(2))
           )
           |> Calc.eval() == {:ok, 5}
  end

  test "failure cases" do
    assert Div.new(
             Val.new(10),
             Val.new(0)
           )
           |> Calc.eval() == {:error, :div_by_zero}
  end
end
