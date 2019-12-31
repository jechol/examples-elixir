defmodule Example.ReaderCalc do
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.Reader
  import Algae.Reader

  def eval(%Val{val: val}) do
    monad %Reader{} do
      %{max: max} <- ask()

      return check_overflow(val, max)
    end
  end

  def eval(%Div{num: num, denom: denom}) do
    monad %Reader{} do
      # `Reader` context.
      # `ask()` returns environments given with `Reader.run()`
      %{max: max} <- ask()

      # `ask()` is also available in `eval(num)`,
      # so that we don't need to pass environments `%{max: _}`
      num <- eval(num)
      denom <- eval(denom)

      return (with {:ok, num} <- num,
                   {:ok, denom} <- denom,
                   {:ok, quotient} <- safe_div(num, denom) do
                check_overflow(quotient, max)
              end)
    end
  end

  defp safe_div(_, 0), do: {:error, :div_by_zero}
  defp safe_div(n, m), do: {:ok, n / m}

  defp check_overflow(num, max) do
    if num > max, do: {:error, :overflow}, else: {:ok, num}
  end
end
