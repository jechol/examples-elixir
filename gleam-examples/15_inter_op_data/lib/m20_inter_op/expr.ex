defmodule Expr do
  import Record

  defrecord(:val, val: nil)
  defrecord(:div, left: nil, right: nil)
end
