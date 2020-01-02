defmodule Example.StateRwCalcTest do
  use ExUnit.Case
  use Witchcraft

  alias Algae.State
  alias Algae.Either.{Left, Right}
  alias Example.Expr.{Val, Div}
  alias Example.StateRwCalc, as: Calc

  test "Val cases" do
    assert Val.new(10)
           |> Calc.eval()
           |> State.run(%{max: 11}) ==
             {%Right{right: 10}, %{max: 11, trace: [%Val{val: 10}]}}

    assert Val.new(10)
           |> Calc.eval()
           |> State.run(%{max: 9}) ==
             {%Left{left: :overflow}, %{max: 9, trace: [%Val{val: 10}]}}
  end

  test "Div with overflow" do
    hundred_over_one_of_ten =
      Div.new(
        Val.new(100),
        Val.new(0.1)
      )
      |> Calc.eval()

    assert hundred_over_one_of_ten |> State.run(%{max: 1500}) ==
             {%Right{right: 1000},
              %{
                max: 1500,
                trace: [
                  %Val{val: 100},
                  %Val{val: 0.1},
                  %Div{denom: %Right{right: 0.1}, num: %Right{right: 100}}
                ]
              }}

    assert hundred_over_one_of_ten |> State.run(%{max: 500}) ==
             {%Left{left: :overflow},
              %{
                max: 500,
                trace: [
                  %Val{val: 100},
                  %Val{val: 0.1},
                  %Div{
                    denom: %Right{right: 0.1},
                    num: %Right{right: 100}
                  }
                ]
              }}

    assert hundred_over_one_of_ten |> State.run(%{max: 10}) ==
             {%Left{left: :overflow},
              %{
                max: 10,
                trace: [
                  %Val{val: 100},
                  %Val{val: 0.1},
                  %Div{
                    denom: %Right{right: 0.1},
                    num: %Left{left: :overflow}
                  }
                ]
              }}
  end

  test "Div with div_by_zero" do
    hundred_over_zero =
      Div.new(
        Val.new(100),
        Val.new(0)
      )
      |> Calc.eval()

    assert hundred_over_zero |> State.run(%{max: 10}) ==
             {%Left{left: :overflow},
              %{
                max: 10,
                trace: [
                  %Val{val: 100},
                  %Val{val: 0},
                  %Div{
                    denom: %Right{right: 0},
                    num: %Left{left: :overflow}
                  }
                ]
              }}

    assert hundred_over_zero |> State.run(%{max: 1000}) ==
             {%Left{left: :div_by_zero},
              %{
                max: 1000,
                trace: [
                  %Val{val: 100},
                  %Val{val: 0},
                  %Div{
                    denom: %Right{right: 0},
                    num: %Right{right: 100}
                  }
                ]
              }}
  end
end
