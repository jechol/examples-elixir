defmodule MaybeBindTest do
  use ExUnit.Case

  alias Maybe.{Just, Nothing}

  import MaybeBind, only: [bind: 2]

  def inc(n), do: Just.new(n + 1)

  test "Just" do
    assert Just.new(1) |> bind(&inc/1) == Just.new(2)
    assert Just.new(1) |> bind(&inc/1) |> bind(&inc/1) == Just.new(3)
  end

  test "Nothing" do
    assert Nothing.new() |> bind(&inc/1) == Nothing.new()
  end
end
