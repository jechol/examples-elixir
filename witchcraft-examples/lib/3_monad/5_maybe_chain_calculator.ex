defmodule Seminar.Monad.MaybeChainCalculator do
  use Witchcraft

  alias Seminar.Monad.Expr.{Val, Div}
  alias Algae.Maybe.{Just, Nothing}

  def eval(%Val{val: val}), do: Just.new(val)

  def eval(%Div{num: num, denom: denom}) do
    chain(eval(num), fn num_val ->
      chain(eval(denom), fn denom_val -> safe_div(num_val, denom_val) end)
    end)
  end

  defp safe_div(_, 0), do: Nothing.new()
  defp safe_div(n, m), do: Just.new(n / m)
end
