defmodule Example.StateStackUnsafeCalc do
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.State

  import Algae.State

  def eval(%Val{val: val}) do
    monad %State{} do
      modify fn stack -> [val | stack] end
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
end
