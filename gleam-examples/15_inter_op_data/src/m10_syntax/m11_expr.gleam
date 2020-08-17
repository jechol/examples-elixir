import gleam/result.{Result}

pub type Expr {
  Val(val: Float)
  Div(num: Expr, denom: Expr)
}

pub type DivErr {
  DivByZero
}

pub fn safe_div(num: Float, denom: Float) -> Result(Float, DivErr) {
  case denom {
    0.0 -> Error(DivByZero)
    denom -> Ok(num /. denom)
  }
}

pub fn eval(expr: Expr) -> Result(Float, DivErr) {
  case expr {
    Val(val: val) -> Ok(val)
    Div(num: num, denom: denom) -> {
      try num_val = eval(num)
      try denom_val = eval(denom)
      safe_div(num_val, denom_val)
    }
  }
  // case eval(num) {
  //   Ok(num_val) -> {
  //     case eval(denom) {
  //       Ok(denom_val) -> safe_div(num_val, denom_val)
  //       e -> e
  //     }
  //   }
  //   e -> e
  // }
}
