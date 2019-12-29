defmodule EitherTest do
  use ExUnit.Case, async: true

  use Witchcraft
  alias Algae.Either.{Left, Right}
  alias Witchcraft.{Setoid, Functor, Apply, Applicative, Monad}

  # ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗ ██████╗ ██████╗
  # ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗
  # █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║   ██║██████╔╝
  # ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║   ██║██╔══██╗
  # ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ╚██████╔╝██║  ██║
  # ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝

  def parse({200, body}), do: body

  test "Functor" do
    assert (&parse/1) <~ Right.new({200, "body"}) == %Right{right: "body"}
    assert (&parse/1) <~ Left.new(400) == %Left{left: 400}
  end

  # █████╗ ██████╗ ██████╗ ██╗     ██╗ ██████╗ █████╗ ████████╗██╗██╗   ██╗███████╗
  # ██╔══██╗██╔══██╗██╔══██╗██║     ██║██╔════╝██╔══██╗╚══██╔══╝██║██║   ██║██╔════╝
  # ███████║██████╔╝██████╔╝██║     ██║██║     ███████║   ██║   ██║██║   ██║█████╗
  # ██╔══██║██╔═══╝ ██╔═══╝ ██║     ██║██║     ██╔══██║   ██║   ██║╚██╗ ██╔╝██╔══╝
  # ██║  ██║██║     ██║     ███████╗██║╚██████╗██║  ██║   ██║   ██║ ╚████╔╝ ███████╗
  # ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═══╝  ╚══════╝

  def decode(:json, body), do: {:ok, Jason.decode!(body)}
  def decode(_, _), do: :error

  describe "Applicative" do
    test "limitation of Functor" do
      assert decode(:json, "{}") == %{}

      assert_raise ArgumentError, fn ->
        (&decode/2) <~ Right.new(:json) <~ Right.new("{}")
      end
    end

    test "cases" do
      assert (&decode/2) <~ Right.new(:json) <<~ Right.new("{}") == %Right{right: {:ok, %{}}}
      assert (&decode/2) <~ Right.new(:json) <<~ Left.new(:empty) == %Left{left: :empty}
      assert (&decode/2) <~ Left.new(:no_mime) <<~ Right.new(<<1>>) == %Left{left: :no_mime}
      assert (&decode/2) <~ Left.new(:no_mime) <<~ Left.new(:empty) == %Left{left: :no_mime}
      assert (&decode/2) <~ Right.new(:jpg) <<~ Right.new(<<1>>) == %Right{right: :error}
    end
  end

  # ██╗   ███╗ ██████╗ ███╗   ██╗ █████╗ ██████╗
  # ████╗ ████║██╔═══██╗████╗  ██║██╔══██╗██╔══██╗
  # ██╔████╔██║██║   ██║██╔██╗ ██║███████║██║  ██║
  # ██║╚██╔╝██║██║   ██║██║╚██╗██║██╔══██║██║  ██║
  # ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║  ██║██████╔╝
  # ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═════╝

  def decode({:json, body}), do: body |> Jason.decode!() |> Right.new()
  def decode({mime, _body}), do: :unknown_mime |> Left.new()

  # describe "Monad" do
  #   test "limitation of Apply" do
  #     # Right, ok duplicated => should be %Right{right: %{}}
  #     assert (&decode/2) <~ Right.new(:json) <<~ Right.new("{}") == %Right{right: {:ok, %{}}}
  #     # Right, error is non-sense => should be %Left{left: :error}
  #     assert (&decode/2) <~ Right.new(:jpg) <<~ Right.new(<<1>>) == %Right{right: :error}
  #   end

  #   test ">>>" do
  #     assert Right.new({:json, "{}"}) >>> (&decode/1) == %Right{right: %{}}
  #     assert Right.new({:gif, <<11>>}) >>> (&decode/1) == %Left{left: :unknown_mime}

  #     assert Left.new(:http_error) >>> (&decode/1) == %Left{left: :http_error}
  #     # parser = fn {200, body} -> Right.new(body) end

  #     # assert Right.new({200, "data"}) >>> parser == %Right{right: "data"}
  #     # assert Left.new(400) >>> parser == %Left{left: 400}
  #   end

  #   def get_inventory(:laptop), do: Right.new(10)
  #   def get_inventory(:desktop), do: Right.new(1)
  #   def get_price(:laptop), do: Right.new(1000)
  #   def get_price(:desktop), do: Left.new(:price_unavailable) |> IO.inspect()

  #   def assert_inventory_suffice(inventory, required) do
  #     if required <= inventory do
  #       Right.new()
  #     else
  #       Left.new(:out_of_stock)
  #     end
  #   end

  #   def get_total_price(type, count) do
  #     monad %Right{} do
  #       inventory <- get_inventory(type)

  #       if inventory < count do
  #         Left.new(:out_of_inventory)
  #       else
  #         # return(price * count)
  #         Right.new(inventory)
  #       end
  #     end
  #   end

  #   test "do_notation" do
  #     get_total_price(:desktop, 6) |> IO.inspect()
  #     # assert get_total_price(:desktop, 1) == Right.new(1000)
  #     # assert get_total_price(:laptop, 1) == Right.new(1000)
  #   end

  #   test "success" do
  #     fetch_num_computers = fn -> Right.new(10) end
  #     fetch_price = fn -> Right.new(500) end

  #     total_price =
  #       chain do
  #         num <- fetch_num_computers.()
  #         price <- fetch_price.()
  #         let sale = 0.9
  #         Right.new(num * price * sale)
  #       end

  #     assert total_price == %Right{right: 4500}
  #   end

  #   test "fail" do
  #     fetch_num_computers = fn -> Right.new(10) end
  #     fetch_price = fn -> Left.new(:price_not_found) end

  #     total_price =
  #       chain do
  #         num <- fetch_num_computers.()
  #         price <- fetch_price.()
  #         Right.new(num * price)
  #       end

  #     assert total_price == %Left{left: :price_not_found}
  #   end
  # end
end
