defmodule Example.StateStackCalcTest do
  use ExUnit.Case
  use Witchcraft

  alias Algae.State
  alias Example.Expr.{Val, Div}
  alias Example.StateStackCalc, as: Calc

  test "success val" do
    assert Val.new(2) |> Calc.eval() |> State.run([]) == {:ok, [2]}
  end

  test "success div" do
    assert Div.new(
             Val.new(4),
             Val.new(2)
           )
           |> Calc.eval()
           |> State.run([]) == {:ok, [2]}

    assert Div.new(
             Val.new(10),
             Div.new(Val.new(4), Val.new(2))
           )
           |> Calc.eval()
           |> State.run([]) == {:ok, [5]}
  end

  test "failure cases" do
    assert_raise ArithmeticError, fn ->
      Div.new(
        Val.new(10),
        Val.new(0)
      )
      |> Calc.eval()
      |> State.run([])
    end
  end
end
