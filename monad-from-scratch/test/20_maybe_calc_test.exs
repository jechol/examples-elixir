defmodule MaybeCalcTest do
  use ExUnit.Case

  alias Expr.{Val, Div}
  alias Maybe.{Just, Nothing}

  @calcs [MaybeCaseCalc, MaybeBindCalc]
  # @calcs [MaybeCaseCalc, MaybeChainCalc, MaybeOpCalc, MaybeDoCalc]

  test "success cases" do
    for calc <- @calcs do
      assert Val.new(2) |> calc.eval() == %Just{just: 2}

      assert Div.new(
               Val.new(4),
               Val.new(2)
             )
             |> calc.eval() == %Just{just: 2}

      assert Div.new(
               Val.new(10),
               Div.new(Val.new(4), Val.new(2))
             )
             |> calc.eval() == %Just{just: 5}
    end
  end

  test "failure cases" do
    for calc <- @calcs do
      assert Div.new(
               Val.new(10),
               Val.new(0)
             )
             |> calc.eval() == %Nothing{}
    end
  end
end
