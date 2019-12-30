defmodule Seminar.Adt.ExprTest do
  use ExUnit.Case

  alias Seminar.Adt.Expr.{Val, Div}

  test "Val" do
    assert Val.new(1) == %Val{val: 1}
  end

  test "Div" do
    seven_over_two = Div.new(Val.new(7), Val.new(2))

    assert seven_over_two ==
             %Div{num: %Val{val: 7}, denom: %Val{val: 2}}

    assert Div.new(Val.new(10), seven_over_two) ==
             %Div{
               num: %Val{val: 10},
               denom: %Div{num: %Val{val: 7}, denom: %Val{val: 2}}
             }
  end
end
