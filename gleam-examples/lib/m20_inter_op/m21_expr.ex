defmodule M20InterOp.M21Expr do
  import Record

  # pub type Expr {
  #   Val(val: Float)             // Elixir {:val, val}
  #   Div(num: Expr, denom: Expr) // Elixir {:div, num, denom}
  # }

  # {:val, val}
  defrecord(:val, val: nil)
  # {:div, left, denom}
  defrecord(:div, num: nil, denom: nil)
end
