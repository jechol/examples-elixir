defmodule ReaderExample do
  use Witchcraft

  import Algae.Reader

  def local_e do
    a =
      ask()
      |> local(fn word -> word <> "!" end)

    b = a |> local(&String.upcase/1)

    c = b |> run("o hai thar")

    {a, b, c}
  end
end
