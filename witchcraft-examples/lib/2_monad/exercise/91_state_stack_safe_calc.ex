defmodule Example.StateStackSafeCalc do
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.State
  alias Algae.Either.{Left, Right}

  import Algae.State

  def eval(%Val{val: val}) do
    monad %State{} do
      modify fn stack -> [Right.new(val) | stack] end
      return :ok
    end
  end

  def eval(%Div{num: num, denom: denom}) do
    monad %State{} do
      :ok <- eval(denom)
      :ok <- eval(num)

      # Exercise. Fill here using `modify/1`

      return :ok
    end
  end

  defp safe_div(_, 0), do: Left.new(:div_by_zero)
  defp safe_div(n, m), do: Right.new(n / m)
end
