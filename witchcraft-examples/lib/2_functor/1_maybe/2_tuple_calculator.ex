defmodule Seminar.Functor.Maybe.TupleCalculator do
  use Witchcraft

  @ops [:+, :-, :*, :/]

  def eval(n) when is_number(n), do: {:ok, n}

  def eval({op, lhs, rhs}) when op in @ops do
    case eval(lhs) do
      {:ok, l} ->
        case eval(rhs) do
          {:ok, r} ->
            case {op, r} do
              {:/, 0} -> {:error, :div_by_zero}
              _ -> {:ok, apply(Kernel, op, [l, r])}
            end

          {:error, _} = e ->
            e
        end

      {:error, _} = e ->
        e
    end
  end
end
