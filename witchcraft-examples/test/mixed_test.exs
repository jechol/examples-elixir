defmodule MixedTest do
  use ExUnit.Case
  use Witchcraft

  alias Algae.{
    Reader,
    Writer,
    State,
    Maybe,
    Maybe.Just,
    Maybe.Nothing,
    Either,
    Either.Left,
    Either.Right
  }

  import Algae.{Reader, Writer, State, Maybe, Either}

  test "Maybe & Either" do
    # f = fn n ->
    #   Just.new(n) >>>
    #     fn n -> if n >= 100, do: Right.new(n - 100), else: Left.new("Smaller than 100") end >>>
    #     fn n -> if n >= 100, do: Right.new(n - 100), else: Left.new("Smaller than 200") end >>>
    #     fn n -> Just.new(n) end
    # end

    f = fn n ->
      monad %Reader{} do
        n <- Just.new(n)
        n <- if n >= 100, do: Right.new(n - 100), else: Left.new("Smaller than 100")
        n <- if n >= 100, do: Right.new(n - 100), else: Left.new("Smaller than 200")
        Just.new(n)
      end
    end

    f.(1) |> IO.inspect()
    f.(100) |> IO.inspect()
    f.(200) |> IO.inspect()
  end
end
