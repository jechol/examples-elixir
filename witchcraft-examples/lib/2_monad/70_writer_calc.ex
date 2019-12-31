defmodule Example.WriterCalc do
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.Writer
  import Algae.Writer

  def eval(%Val{val: val} = v) do
    monad %Writer{writer: {999, ["sample"]}} do
      # `tell` accumulates monoid values.
      tell [v]

      return {:ok, val}
    end
  end

  def eval(%Div{num: num, denom: denom}) do
    monad %Writer{writer: {999, ["sample"]}} do
      num <- eval(num)
      denom <- eval(denom)

      tell [%Div{num: num, denom: denom}]

      let quotient =
            (with {:ok, num} <- num,
                  {:ok, denom} <- denom do
               safe_div(num, denom)
             end)

      # After desugaring, `return quotient` becomes %Writer{writer: {quotient, []}}
      return quotient
    end
  end

  defp safe_div(_, 0), do: {:error, :div_by_zero}
  defp safe_div(n, m), do: {:ok, n / m}
end
