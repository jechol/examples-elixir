import gleam/should
import m10_syntax/m11_expr.{Div, DivByZero, Expr, Val} as expr

pub fn safe_div_ok_test() {
  expr.safe_div(10.0, 2.0)
  |> should.equal(Ok(5.0))
}

pub fn safe_div_error_test() {
  expr.safe_div(10.0, 0.0)
  |> should.equal(Error(DivByZero))
}

pub fn eval_ok_test() {
  Val(val: 10.0)
  |> expr.eval()
  |> should.equal(Ok(10.0))

  Div(num: Val(10.0), denom: Val(2.0))
  |> expr.eval()
  |> should.equal(Ok(5.0))

  Div(num: Val(10.0), denom: Div(num: Val(4.0), denom: Val(2.0)))
  |> expr.eval()
  |> should.equal(Ok(5.0))
}

pub fn eval_error_test() {
  Div(num: Val(10.0), denom: Val(0.0))
  |> expr.eval()
  |> should.equal(Error(DivByZero))

  Div(num: Val(10.0), denom: Div(num: Val(4.0), denom: Val(0.0)))
  |> expr.eval()
  |> should.equal(Error(DivByZero))
}
