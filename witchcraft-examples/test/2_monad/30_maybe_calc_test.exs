defmodule Example.MaybeCalcTest do
  use ExUnit.Case
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.Maybe.{Just, Nothing}

  @calcs [Example.MaybeCaseCalc, Example.MaybeChainCalc, Example.MaybeOpCalc, Example.MaybeDoCalc]

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
