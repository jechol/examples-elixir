defmodule Example.StateRwCalc do
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.State
  alias Algae.Either.{Left, Right}
  alias Example.Expr.{Val, Div}
  alias Algae.Either.{Left, Right}

  import Algae.State

  # New macros available in `State` monad,
  #
  # 4. get() : {state, state} (Copy state to value so that `<-` binds to state)
  # 5. put(new_state) : {value, new_state}
  # 6. modify(fun) : {value, fun.(state)}

  def eval(%Val{val: val} = v) do
    monad %State{} do
      %{max: max} <- get()

      modify fn state -> state |> trace(v) end

      return check_overflow(val, max)
    end
  end

  def eval(%Div{num: num, denom: denom}) do
    monad %State{} do
      %{max: max} <- get()

      num <- eval(num)
      denom <- eval(denom)

      modify fn state -> state |> trace(Div.new(num, denom)) end

      return (monad %Right{} do
                num_val <- num
                denom_val <- denom

                quotient <- safe_div(num_val, denom_val)
                check_overflow(quotient, max)
              end)
    end
  end

  defp trace(%{trace: trace} = s, val), do: %{s | trace: trace ++ [val]}
  defp trace(%{} = s, val), do: s |> Map.put(:trace, [val])

  # Functions: Pure arguments -> Wrapped return value

  defp safe_div(_, 0), do: Left.new(:div_by_zero)
  defp safe_div(n, m), do: Right.new(n / m)

  defp check_overflow(num, max) do
    if num > max, do: Left.new(:overflow), else: Right.new(num)
  end
end
