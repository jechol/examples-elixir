defmodule EnumerableVsFunctorTest do
  use ExUnit.Case, async: true

  use Witchcraft
  alias Algae.Either.{Left, Right}
  alias Witchcraft.{Setoid, Functor, Apply, Applicative, Monad}

  describe "Elixir Enumerable" do
    test "list" do
      x = [1] |> Enum.map(fn x -> x * 100 end)

      assert x == [100]
    end

    test "map" do
      x = %{val: 1} |> Enum.map(fn {k, v} -> {k, v * 100} end)

      # Enum.map() always returns list, no matter what original container was.
      assert x == [val: 100]
    end
  end

  describe "Witchcraft Functor" do
    test "list" do
      x = [1] ~> fn x -> x * 100 end

      assert x == [100]
    end

    test "map" do
      x = %{val: 1} ~> fn x -> x * 100 end

      # `~>` returns original container.map.
      # For map: https://github.com/witchcrafters/witchcraft/blob/d821ebf74777805b260a705380bde8ca837d18a5/lib/witchcraft/functor.ex#L332
      assert x == %{val: 100}
    end
  end
end
