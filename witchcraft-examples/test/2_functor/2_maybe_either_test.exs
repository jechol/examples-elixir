defmodule Seminar.Functor.MaybeEitherTest do
  use ExUnit.Case

  import Witchcraft.Functor
  alias Algae.Maybe

  test "Maybe" do
    assert %Maybe.Just{just: 10} ~> (&(&1 * 2)) == %Maybe.Just{just: 20}
    assert %Maybe.Just{just: 10} ~> (&(&1 * 2)) ~> (&(&1 - 1)) == %Maybe.Just{just: 19}

    assert %Maybe.Nothing{} ~> (&(&1 * 2)) == %Maybe.Nothing{}
  end

  alias Algae.Either

  test "Either" do
    assert %Either.Right{right: 10} ~> (&(&1 * 2)) == %Either.Right{right: 20}
    assert %Either.Right{right: 10} ~> (&(&1 * 2)) ~> (&(&1 - 1)) == %Either.Right{right: 19}

    assert %Either.Left{left: :NAN} ~> (&(&1 * 2)) == %Either.Left{left: :NAN}
  end
end
