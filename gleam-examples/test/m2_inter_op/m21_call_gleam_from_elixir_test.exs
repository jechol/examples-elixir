defmodule M2InterOp.M21CallGleamFromElixirTest do
  use ExUnit.Case
  require M2InterOp.M21Expr, as: Expr

  test "record" do
    # Gleam Val(val: 10.0)
    assert Expr.val(val: 10.0) == {:val, 10.0}

    # Gleam Div(num: Expr, denom: Expr)
    assert Expr.div(num: Expr.val(val: 10.0), denom: Expr.val(val: 2.0)) ==
             {:div, {:val, 10.0}, {:val, 2.0}}
  end

  test "safe_div" do
    # Gleam Ok(5.0) == Elixir {:ok, 5.0}
    assert :m1_syntax@m11_expr.safe_div(10.0, 2.0) == {:ok, 5.0}

    # Gleam Error(DivByZero) == Elixir {:error, :div_by_zero}
    assert :m1_syntax@m11_expr.safe_div(10.0, 0.0) == {:error, :div_by_zero}
  end

  test "eval" do
    div_10_by_2 = Expr.div(num: Expr.val(val: 10.0), denom: Expr.val(val: 2.0))
    assert :m1_syntax@m11_expr.eval(div_10_by_2) == {:ok, 5.0}

    div_10_by_0 = Expr.div(num: Expr.val(val: 10.0), denom: Expr.val(val: 0.0))
    assert :m1_syntax@m11_expr.eval(div_10_by_0) == {:error, :div_by_zero}
  end
end
