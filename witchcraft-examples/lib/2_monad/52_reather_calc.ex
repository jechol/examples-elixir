defmodule Example.ReatherCalc do
  use Reather

  alias Example.Expr.{Val, Div}

  def eval(%Val{val: val}) do
    monad %Reather{} do
      %{max: max} <- Reather.ask()

      return check_overflow(val, max)
    end
  end

  def eval(%Div{num: num, denom: denom}) do
    monad %Reather{} do
      %{max: max} <- Reather.ask()

      num <- eval(num)
      denom <- eval(denom)

      quotient <- return safe_div(num, denom)
      return check_overflow(quotient, max)
    end
  end

  # Functions: Pure arguments -> Wrapped return value

  defp safe_div(_, 0), do: Left.new(:div_by_zero)
  defp safe_div(n, m), do: Right.new(n / m)

  defp check_overflow(num, max) do
    if num > max, do: Left.new(:overflow), else: Right.new(num)
  end
end
