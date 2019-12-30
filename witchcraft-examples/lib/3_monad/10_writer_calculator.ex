defmodule Seminar.Monad.WriterCalculator do
  use Witchcraft

  alias Seminar.Monad.Expr.{Val, Div}
  alias Algae.Writer
  import Algae.Writer

  def eval(%Val{val: val}) do
    monad %Writer{writer: {999, "sample"}} do
      tell "Found #{val}\n"

      return val
    end
  end

  def eval(%Div{num: num, denom: denom}) do
    monad %Writer{writer: {999, "sample"}} do
      num_val <- eval(num)
      denom_val <- eval(denom)
      let quotient = safe_div(num_val, denom_val)

      tell "Evaluating #{num_val} / #{denom_val} = #{quotient}\n"

      return quotient
      # Desugaring "return quotient" becomes
      # %Writer{writer: {quotient, ""}}
    end
  end

  defp safe_div(_, 0), do: :div_by_zero
  defp safe_div(n, m), do: n / m
end
