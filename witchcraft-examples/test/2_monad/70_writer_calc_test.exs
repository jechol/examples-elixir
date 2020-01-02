defmodule Example.WriterCalcTest do
  use ExUnit.Case
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Example.WriterCalc, as: Calc
  alias Algae.Writer
  alias Algae.Either.{Left, Right}

  test "success cases" do
    assert Val.new(9)
           |> Calc.eval()
           |> Writer.run() ==
             {%Right{right: 9}, [%Val{val: 9}]}

    assert Div.new(
             Val.new(10),
             Div.new(
               Val.new(6),
               Val.new(3)
             )
           )
           |> Calc.eval()
           |> Writer.run() ==
             {%Right{right: 5},
              [
                %Val{val: 10},
                %Val{val: 6},
                %Val{val: 3},
                %Div{num: %Right{right: 6}, denom: %Right{right: 3}},
                %Div{num: %Right{right: 10}, denom: %Right{right: 2}}
              ]}
  end

  test "failure cases" do
    assert Div.new(
             Val.new(10),
             Val.new(0)
           )
           |> Calc.eval()
           |> Writer.run() ==
             {%Left{left: :div_by_zero},
              [
                %Val{val: 10},
                %Val{val: 0},
                %Div{num: %Right{right: 10}, denom: %Right{right: 0}}
              ]}
  end
end
