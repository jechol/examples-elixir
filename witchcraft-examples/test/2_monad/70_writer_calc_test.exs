defmodule Example.WriterCalcTest do
  use ExUnit.Case
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Example.WriterCalc, as: Calc
  alias Algae.Writer

  test "success cases" do
    assert Val.new(9)
           |> Calc.eval()
           |> Writer.run() ==
             {{:ok, 9}, [%Val{val: 9}]}

    assert Div.new(
             Val.new(10),
             Div.new(
               Val.new(6),
               Val.new(3)
             )
           )
           |> Calc.eval()
           |> Writer.run() ==
             {{:ok, 5.0},
              [
                %Val{val: 10},
                %Val{val: 6},
                %Val{val: 3},
                %Div{num: {:ok, 6}, denom: {:ok, 3}},
                %Div{num: {:ok, 10}, denom: {:ok, 2}}
              ]}
  end
end
