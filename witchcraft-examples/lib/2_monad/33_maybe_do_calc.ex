defmodule Example.MaybeDoCalc do
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.Maybe.{Just, Nothing}

  # Macros available in every monad,
  #
  # 1. value <- monad : Unwraps a value from a monad.
  # 2. return value : Wraps a value into a monad.
  # 3. let var = value : Binding

  def eval(%Val{val: val}), do: Just.new(val)

  def eval(%Div{num: num, denom: denom}) do
    monad %Just{} do
      num_val <- eval(num)
      denom_val <- eval(denom)
      safe_div(num_val, denom_val)
    end
  end

  defp safe_div(_, 0), do: Nothing.new()
  defp safe_div(n, m), do: Just.new(n / m)
end
