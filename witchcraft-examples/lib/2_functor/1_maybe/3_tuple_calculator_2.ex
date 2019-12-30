defmodule Seminar.Functor.Maybe.RailwayCalculator do
  use Witchcraft

  @ops [:+, :-, :*, :/]

  def eval(n) when is_number(n), do: {:ok, n}

  def eval({op, lhs, rhs}) when op in @ops do
    with {:ok, l} <- eval(lhs),
         {:ok, r} <- eval(rhs) do
      case {op, r} do
        {:/, 0} -> {:error, :div_by_zero}
        _ -> {:ok, apply(Kernel, op, [l, r])}
      end
    end
  end
end
