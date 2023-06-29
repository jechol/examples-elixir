defmodule TupleCalcTest do
  use ExUnit.Case

  alias Expr.{Val, Div}

  @calcs [TupleCaseCalc, TupleWithCalc, RailCalc]

  test "success cases" do
    for calc <- @calcs do
      assert Val.new(2) |> calc.eval() == {:ok, 2}

      assert Div.new(
               Val.new(4),
               Val.new(2)
             )
             |> calc.eval() == {:ok, 2}

      assert Div.new(
               Val.new(10),
               Div.new(Val.new(4), Val.new(2))
             )
             |> calc.eval() == {:ok, 5}
    end
  end

  test "failure cases" do
    for calc <- @calcs do
      assert Div.new(
               Val.new(10),
               Val.new(0)
             )
             |> calc.eval() == {:error, :div_by_zero}
    end
  end
end
