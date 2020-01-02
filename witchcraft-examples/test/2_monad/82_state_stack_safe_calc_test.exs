defmodule Example.StateStackRwCalcTest do
  use ExUnit.Case
  use Witchcraft

  alias Algae.State
  alias Algae.Either.{Left, Right}
  alias Example.Expr.{Val, Div}
  alias Example.StateStackSafeCalc, as: Calc

  test "success val" do
    assert Val.new(2) |> Calc.eval() |> State.run([]) == {:ok, [%Right{right: 2}]}
  end

  test "success div" do
    assert Div.new(
             Val.new(4),
             Val.new(2)
           )
           |> Calc.eval()
           |> State.run([]) == {:ok, [%Right{right: 2}]}

    assert Div.new(
             Val.new(10),
             Div.new(Val.new(4), Val.new(2))
           )
           |> Calc.eval()
           |> State.run([]) == {:ok, [%Right{right: 5}]}
  end

  test "failure cases" do
    assert Div.new(
             Val.new(10),
             Val.new(0)
           )
           |> Calc.eval()
           |> State.run([]) ==
             {:ok, [%Left{left: :div_by_zero}]}
  end
end
