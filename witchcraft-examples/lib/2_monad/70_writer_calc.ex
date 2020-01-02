defmodule Example.WriterCalc do
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.Writer
  alias Algae.Either.{Left, Right}
  import Algae.Writer

  # Macros available in `Writer` monad,
  #
  # 4. tell(log_entry) : Returns a writer that appends `log_entry` to log.

  def eval(%Val{val: val} = v) do
    monad %Writer{writer: {999, ["sample"]}} do
      # `tell` accumulates monoid values.
      tell [v]

      return Right.new(val)
    end
  end

  def eval(%Div{num: num, denom: denom}) do
    monad %Writer{writer: {999, ["sample"]}} do
      num <- eval(num)
      denom <- eval(denom)

      tell [%Div{num: num, denom: denom}]

      let quotient =
            (monad %Right{} do
               # In `Either` context.
               # So ask() is no longer available.
               num_val <- num
               denom_val <- denom

               safe_div(num_val, denom_val)
             end)

      # After desugaring, `return quotient` becomes %Writer{writer: {quotient, []}}
      return quotient
    end
  end

  defp safe_div(_, 0), do: Left.new(:div_by_zero)
  defp safe_div(n, m), do: Right.new(n / m)
end
