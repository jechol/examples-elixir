defmodule Example.MonoidTest do
  use ExUnit.Case
  use Witchcraft

  # Beware! Monoid is not monad!
  # It's just used in Writer monad to append logs.

  alias Witchcraft.{Semigroup, Monoid}

  test "string" do
    assert Monoid.empty("sample") == ""
    assert Semigroup.append("hello", "world") == "helloworld"
  end

  test "integer" do
    assert Monoid.empty(999) == 0
    assert Semigroup.append(10, 30) == 40
  end

  test "list" do
    assert Monoid.empty([1, 2]) == []
    assert Semigroup.append([1, 2], [3]) == [1, 2, 3]
  end

  test "map" do
    assert Monoid.empty(%{a: 10}) == %{}
    assert Semigroup.append(%{a: 10}, %{b: 20}) == %{a: 10, b: 20}
  end

  test "function" do
    assert Monoid.empty(fn -> nil end) == (&Quark.id/1)
    assert Semigroup.append(&(&1 * 10), &(&1 + 1)).(2) == 21
  end
end
