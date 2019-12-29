defmodule ReaderTest do
  use ExUnit.Case, async: true

  use Witchcraft
  alias Witchcraft.{Functor, Apply, Monad, Unit}

  alias Algae.{Reader, Writer, State}
  import Algae.{Reader, Writer, State}

  test "Reader" do
    greeting =
      monad %Reader{} do
        name <- ask(fn %{name: name} -> name end)
        return("Hello, #{name}.")
      end

    balance_info =
      monad %Reader{} do
        balance <- ask(fn %{balance: balance} -> balance end)
        return("You have #{balance} USD.")
      end

    build_message =
      monad %Reader{} do
        g <- greeting
        b <- balance_info
        return("#{g}\n#{b}")
      end

    msg = build_message |> Reader.run(%{name: "Dave", balance: 1000})

    assert msg == "Hello, Dave.\nYou have 1000 USD."
  end

  test "Writer" do
    send = fn {balance, amount} ->
      monad %Writer{writer: {0, []}} do
        tell([{:email, "Sent #{amount} USD"}])
        return(balance - amount)
      end
    end

    deposit = fn {balance, amount} ->
      monad %Writer{writer: {0, []}} do
        tell([{:email, "Received #{amount} USD"}])
        return(balance + amount)
      end
    end

    bank_work = fn {balance, sent, deposited} ->
      monad %Writer{writer: {0, []}} do
        balance <- send.({balance, sent})
        balance <- deposit.({balance, deposited})
        return(balance)
      end
    end

    bank_work.({100, 10, 20}) |> IO.inspect()
  end

  test "State" do
    s =
      monad %State{} do
        name <- get()
        let result = "Hello, #{name}!"

        put(result)
        modify(&String.upcase/1)

        return(result)
      end

    assert s |> State.run("world") == {"Hello, world!", "HELLO, WORLD!"}
  end

  test "State bank" do
    send = fn amount ->
      monad %State{} do
        modify(fn b -> b - amount end)
      end
    end

    deposit = fn amount ->
      monad %State{} do
        modify(fn b -> b + amount end)
      end
    end

    bank_work = fn sent, deposited ->
      monad %State{} do
        # {%Unit{}, 1000}

        # {%Unit{}, 900}
        send.(sent)
        # {%Unit{}, 1100}
        deposit.(deposited)

        # {1100, 1100}
        get()
      end
    end

    assert bank_work.(100, 200) |> State.run(1000) == {1100, 1100}
  end
end
