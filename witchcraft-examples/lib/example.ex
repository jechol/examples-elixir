defmodule Example do
  use Witchcraft

  import Algae.Reader
  import Algae.Writer

  def reader do
    correct =
      monad %Algae.Reader{} do
        count <- ask(&Map.get(&1, :count))
        bindings <- ask()
        return(count == map_size(bindings))
      end

    sample_bindings = %{count: 3, a: 1, b: 2}
    _correct_count = run(correct, sample_bindings) |> IO.inspect(label: "correct_count")

    bad_bindings = %{count: 100, a: 1, b: 2}
    _bad_count = run(correct, bad_bindings) |> IO.inspect(label: "bad bindings")

    correct
  end

  def writer_1 do
    excite = fn string ->
      monad writer({0.0, "log"}) do
        tell(string)

        excited <- return("#{string}!")
        tell(" => #{excited} ...")

        return(excited)
      end
    end

    {_string, _logs} =
      "Hi"
      |> excite.() >>> excite >>> excite
      |> censor(&String.trim_trailing(&1, " ..."))
      |> run()
  end

  def writer_2 do
    exponent = fn num ->
      monad writer({0, 0}) do
        tell(1)
        return(num * num)
      end
    end

    initial = 42
    {_result, _times} = run(exponent.(initial) >>> exponent >>> exponent)
  end

  def writer_3 do
    half = fn num ->
      monad writer({0.0, [""]}) do
        let(half = num / 2)
        tell(["#{num} / 2 = #{half}"])
        return(half)
      end
    end

    run(half.(42) >>> half >>> half)
  end

  def writer_own_1 do
    half = fn num ->
      monad writer({0.0, [""]}) do
        let(half = num / 2)
        tell(["#{num} / 2 = #{half}"])
        return(half)
      end
    end

    half.(1)
  end

  def writer_listen do
    monad new(1, 1) do
      wr <- listen(tell(42))
      tell(43)
      return(wr)
    end
  end

  def writer_pass_1 do
    pass(%Algae.Writer{writer: {{1, fn x -> x * 10 end}, 42}})
  end

  def writer_pass_2 do
    monad new("string", ["logs"]) do
      a <- ["start"] |> tell() |> listen() |> IO.inspect()
      return(a |> IO.inspect())
    end
  end

  def writer_censor_1 do
    new(42, ["hi", "THERE", "friend"])
    |> censor(&Enum.reject(&1, fn log -> String.upcase(log) == log end))
  end

  def writer_censor_2 do
    monad new(0, ["logs"]) do
      tell(["Start"])
      tell(["BANG!"])
      tell(["shhhhhhhhh...."])
      tell(["LOUD NOISES!!!"])
      return(42)
      tell(["End"])
    end
  end

  alias Algae.Either
  require Integer

  def either_1 do
    fn value ->
      if Integer.is_even(value) do
        Either.Right.new(value)
      else
        Either.Left.new(value)
      end
    end

    # even_odd.(10)
  end
end
