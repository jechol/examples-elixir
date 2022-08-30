defmodule Example.ReaderTupleCalc do
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.Reader
  import Algae.Reader

  # New macros available in `Reader` monad,
  #
  # 4. ask() : A reader that returns environment given with `Reader.run(env)`
  # 5. local(reader, fun) : Run reader with env locally modified by funtion `fun`.

  def eval(%Val{val: val}) do
    monad %Reader{} do
      %{max: max} <- ask()

      return check_overflow(val, max)
    end
  end

  def eval(%Div{num: num, denom: denom}) do
    monad %Reader{} do
      #  Same with %{max: max} <- %Reader{reader: fn env -> env end}
      %{max: max} <- ask()

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
