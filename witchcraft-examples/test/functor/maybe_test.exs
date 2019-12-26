defmodule MaybeTest do
  use ExUnit.Case, async: true

  use Witchcraft
  alias Algae.Either.{Left, Right}
  alias Witchcraft.{Setoid, Functor, Apply, Applicative, Monad}

  defmodule User do
    defstruct id: nil, name: nil

    def get(1 = _id), do: %User{id: 1, name: "jose"}
    def get(_id), do: nil

    def get_name(%User{name: name}), do: name
  end

  describe "Elixir way" do
    def get_user_name(id) do
      id
      |> User.get()
      |> User.get_name()
    end

    test "unsafe get_user_name" do
      assert get_user_name(1) == "jose"
      assert_raise FunctionClauseError, fn -> get_user_name(2) end
    end

    def safe_get_user_name(id) do
      case user = id |> User.get() do
        nil -> nil
        %User{} -> user |> User.get_name()
      end
    end

    test "safe get_user_name" do
      assert safe_get_user_name(1) == "jose"
      assert safe_get_user_name(2) == nil
    end
  end
end
