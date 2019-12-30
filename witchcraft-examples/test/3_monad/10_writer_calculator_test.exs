defmodule Seminar.Monad.WriterCalculatorTest do
  use ExUnit.Case
  use Witchcraft

  alias Seminar.Adt.Expr.{Val, Div}
  alias Seminar.Monad.WriterCalculator, as: Calc
  alias Algae.Writer

  test "success cases" do
    assert Val.new(9) |> Calc.eval() == %Writer{writer: {9, "Found 9\n"}}

    assert Div.new(
             Val.new(100),
             Val.new(2)
           )
           |> Calc.eval() == %Writer{
             writer:
               {50.0,
                """
                Found 100
                Found 2
                Evaluating 100 / 2 = 50.0
                """}
           }
  end
end
