defmodule Example.ReatherCalcTest do
  use ExUnit.Case
  use Reather

  alias Example.Expr.{Val, Div}
  alias Example.ReatherCalc, as: Calc

  test "Val cases" do
    assert Val.new(10)
           |> Calc.eval()
           |> Reather.run(%{max: 11}) == %Right{right: 10}

    assert Val.new(10)
           |> Calc.eval()
           |> Reather.run(%{max: 9}) == %Left{left: :overflow}
  end

  test "Div with overflow" do
    hundred_over_one_of_ten =
      Div.new(
        Val.new(100),
        Val.new(0.1)
      )
      |> Calc.eval()

    assert hundred_over_one_of_ten |> Reather.run(%{max: 1500}) == %Right{right: 1000}
    assert hundred_over_one_of_ten |> Reather.run(%{max: 500}) == %Left{left: :overflow}
    assert hundred_over_one_of_ten |> Reather.run(%{max: 10}) == %Left{left: :overflow}
  end

  test "Div with div_by_zero" do
    hundred_over_zero =
      Div.new(
        Val.new(100),
        Val.new(0)
      )
      |> Calc.eval()

    assert hundred_over_zero |> Reather.run(%{max: 10}) == %Left{left: :overflow}
    assert hundred_over_zero |> Reather.run(%{max: 1000}) == %Left{left: :div_by_zero}
  end
end
