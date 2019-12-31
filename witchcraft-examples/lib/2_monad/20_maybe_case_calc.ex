defmodule Example.MaybeCaseCalc do
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.Maybe.{Just, Nothing}

  def eval(%Val{val: val}), do: Just.new(val)

  def eval(%Div{num: num, denom: denom}) do
    case eval(num) do
      %Nothing{} ->
        Nothing.new()

      %Just{just: num_val} ->
        case eval(denom) do
          %Nothing{} -> Nothing.new()
          %Just{just: denom_val} -> safe_div(num_val, denom_val)
        end
    end
  end

  defp safe_div(_, 0), do: Nothing.new()
  defp safe_div(n, m), do: Just.new(n / m)
end
