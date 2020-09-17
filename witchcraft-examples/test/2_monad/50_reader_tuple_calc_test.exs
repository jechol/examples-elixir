defmodule Example.ReaderTupleCalcTest do
  use ExUnit.Case
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Example.ReaderTupleCalc, as: Calc
  alias Algae.Reader

  test "Val cases" do
    assert Val.new(9)
           |> Calc.eval()
           |> Reader.run(%{max: 10}) == {:ok, 9}

    assert Val.new(11)
           |> Calc.eval()
           |> Reader.run(%{max: 10}) == {:error, :overflow}
  end

  test "Div with overflow" do
    hundred_over_one_of_ten =
      Div.new(
        Val.new(100),
        Val.new(0.1)
      )
      |> Calc.eval()

    assert hundred_over_one_of_ten |> Reader.run(%{max: 1500}) == {:ok, 1000}
    assert hundred_over_one_of_ten |> Reader.run(%{max: 500}) == {:error, :overflow}
    assert hundred_over_one_of_ten |> Reader.run(%{max: 10}) == {:error, :overflow}
  end

  test "Div with div_by_zero" do
    hundred_over_zero =
      Div.new(
        Val.new(100),
        Val.new(0)
      )
      |> Calc.eval()

    assert hundred_over_zero |> Reader.run(%{max: 10}) == {:error, :overflow}
    assert hundred_over_zero |> Reader.run(%{max: 1000}) == {:error, :div_by_zero}
  end
end
