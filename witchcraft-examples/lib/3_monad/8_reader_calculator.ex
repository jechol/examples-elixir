defmodule Seminar.Monad.ReaderCalculator do
  use Witchcraft

  alias Seminar.Monad.Expr.{Val, Div}
  alias Algae.Reader
  import Algae.Reader

  def eval(%Val{val: val}) do
    check_overflow(val)
  end

  def eval(%Div{num: num, denom: denom}) do
    chain do
      num_val <- eval(num)
      denom_val <- eval(denom)
      let quotient = safe_div(num_val, denom_val)
      check_overflow(quotient)
    end
  end

  defp safe_div(:overflow, _), do: :overflow
  defp safe_div(_, :overflow), do: :overflow
  defp safe_div(_, 0), do: :div_by_zero
  defp safe_div(n, m), do: n / m

  defp check_overflow(val) do
    monad %Reader{} do
      # ask() pulls environment
      %{max: max} <- ask()

      return (if val == :overflow or val > max do
                :overflow
              else
                val
              end)
    end
  end
end
