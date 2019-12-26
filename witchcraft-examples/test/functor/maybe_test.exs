defmodule MaybeTest do
  use ExUnit.Case, async: true

  use Witchcraft
  alias Algae.Maybe
  alias Algae.Maybe.{Just, Nothing}
  alias Algae.Either.{Left, Right}
  alias Witchcraft.{Setoid, Functor, Apply, Applicative, Monad}

  describe "Maybe" do
    def double(n), do: n * 2

    test "Functor.map()" do
      assert %Just{just: 10} |> Functor.map(&double/1) == %Just{just: 20}
      assert %Just{just: 10} ~> (&double/1) == %Just{just: 20}
      assert %Nothing{} ~> (&double/1) == %Nothing{}
    end
  end

  describe "Elixir way" do
    defmodule User do
      defstruct id: nil, name: nil

      def get(1 = _id), do: %User{id: 1, name: "jose"}
      def get(_id), do: nil

      def get_name(%User{name: name}), do: name
    end

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
      # Safe, but verbose.
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

  describe "Algebraic way" do
    defmodule Account do
      defstruct id: nil, name: nil

      def get(1 = _id), do: %Account{id: 1, name: "mccord"}
      def get(_id), do: nil

      def get_name(%Account{name: name}), do: name
    end

    def get_account_name(id) do
      id
      |> Maybe.from_nillable()
      ~> (&Account.get/1)
      ~> (&Account.get_name/1)
    end

    test "get_account_name" do
      assert get_account_name(1) == %Just{just: "mccord"}
      assert get_account_name(nil) == %Nothing{}
    end
  end
end
