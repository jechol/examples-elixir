defmodule Seminar.Adt.ExprTest do
  use ExUnit.Case

  alias Seminar.Adt.Expr.{Val, Div}

  test "Val" do
    assert Val.new(1) == %Val{val: 1}
  end

  test "Div" do
    assert Div.new(Val.new(7), Val.new(2)) ==
             %Div{num: %Val{val: 7}, denom: %Val{val: 2}}

    assert Div.new(Val.new(10), Div.new(Val.new(7), Val.new(2))) ==
             %Div{
               num: %Val{val: 10},
               denom: %Div{num: %Val{val: 7}, denom: %Val{val: 2}}
             }
  end
end
