defmodule Example.EitherCalcTest do
  use ExUnit.Case
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.Either.{Left, Right}

  alias Example.EitherCalc, as: Calc

  test "success cases" do
    assert Val.new(2) |> Calc.eval() == %Right{right: 2}

    assert Div.new(
             Val.new(4),
             Val.new(2)
           )
           |> Calc.eval() == %Right{right: 2}

    assert Div.new(
             Val.new(10),
             Div.new(Val.new(4), Val.new(2))
           )
           |> Calc.eval() == %Right{right: 5}
  end

  test "failure cases" do
    assert Div.new(
             Val.new(10),
             Val.new(0)
           )
           |> Calc.eval() == %Left{left: :div_by_zero}
  end
end
