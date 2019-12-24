defmodule EitherTest do
  use ExUnit.Case, async: true

  use Witchcraft
  alias Algae.Either.{Left, Right}
  alias Witchcraft.{Setoid, Functor, Apply, Applicative, Monad}

  test "Functor" do
    parser = fn {200, body} -> body end

    assert Left.new(400) |> Functor.map(parser) == Left.new(400)
    assert Right.new({200, "data"}) |> Functor.map(parser) == %Right{right: "data"}
  end

  test "Apply" do
    good_resp = Right.new({200, "data"})
    good_parser = Right.new(fn {200, body} -> body end)

    bad_resp = Left.new(400)
    bad_parser = Left.new(:parser_not_found)

    assert good_resp |> Apply.convey(good_parser) == %Right{right: "data"}
    assert good_resp |> Apply.convey(bad_parser) == %Left{left: :parser_not_found}
    assert bad_resp |> Apply.convey(good_parser) == %Left{left: 400}
    assert bad_resp |> Apply.convey(bad_parser) == %Left{left: 400}
  end

  describe "Chain" do
    test "success" do
      fetch_num_computers = fn -> Right.new(10) end
      fetch_price = fn -> Right.new(500) end

      total_price =
        chain do
          num <- fetch_num_computers.()
          price <- fetch_price.()
          let sale = 0.9
          Right.new(num * price * sale)
        end

      assert total_price == %Right{right: 4500}
    end

    test "fail" do
      fetch_num_computers = fn -> Right.new(10) end
      fetch_price = fn -> Left.new(:price_not_found) end

      total_price =
        chain do
          num <- fetch_num_computers.()
          price <- fetch_price.()
          Right.new(num * price)
        end

      assert total_price == %Left{left: :price_not_found}
    end
  end
end
