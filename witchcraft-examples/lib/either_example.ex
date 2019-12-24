defmodule EitherExample do
  use Witchcraft

  alias Algae.Either.{Left, Right}

  def setoid do
    s = get_url("success")
    f = get_url("failure")

    Witchcraft.Setoid.equivalent?(s, s)
  end

  def get_url("failure"), do: Left.new("error")
  def get_url("success"), do: Right.new("data")
end
