defmodule Example.ReaderEitherCalc do
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.Reader
  alias Algae.Either.{Left, Right}

  import Algae.Reader

  def eval(%Val{val: val}) do
    monad %Reader{} do
      %{max: max} <- ask()

      return check_overflow(val, max)
    end
  end

  def eval(%Div{num: num, denom: denom}) do
    monad %Reader{} do
      %{max: max} <- ask()

      num <- eval(num)
      denom <- eval(denom)

      return (monad %Right{} do
                # In `Either` context.
                # So ask() is no longer available.
                num_val <- num
                denom_val <- denom

                quotient <- safe_div(num_val, denom_val)
                check_overflow(quotient, max)
              end)
    end
  end

  # Functions: Pure arguments -> Wrapped return value

  defp safe_div(_, 0), do: Left.new(:div_by_zero)
  defp safe_div(n, m), do: Right.new(n / m)

  defp check_overflow(num, max) do
    if num > max, do: Left.new(:overflow), else: Right.new(num)
  end
end
