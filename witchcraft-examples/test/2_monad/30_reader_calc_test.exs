defmodule Example.ReaderCalculatorTest do
  use ExUnit.Case
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Example.ReaderCalculator, as: Calc
  alias Algae.Reader

  test "success cases" do
    assert Val.new(9)
           |> Calc.eval()
           |> Reader.run(%{max: 10}) == 9

    assert Val.new(11)
           |> Calc.eval()
           |> Reader.run(%{max: 10}) == :overflow

    hundred_over_one_of_ten =
      Div.new(
        Val.new(100),
        Val.new(0.1)
      )
      |> Calc.eval()

    assert hundred_over_one_of_ten |> Reader.run(%{max: 1500}) == 1000
    assert hundred_over_one_of_ten |> Reader.run(%{max: 500}) == :overflow
    assert hundred_over_one_of_ten |> Reader.run(%{max: 10}) == :overflow

    hundred_over_zero =
      Div.new(
        Val.new(100),
        Val.new(0)
      )
      |> Calc.eval()

    assert hundred_over_zero |> Reader.run(%{max: 10}) == :overflow
    assert hundred_over_zero |> Reader.run(%{max: 1000}) == :div_by_zero
  end
end
