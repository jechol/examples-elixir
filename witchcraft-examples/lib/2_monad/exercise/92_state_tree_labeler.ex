defmodule Example.StateTreeLabeler do
  use Witchcraft

  alias Algae.State
  alias Example.Tree

  import Algae.State
  import Witchcraft.Monad

  def label_post_order(%Tree{left: _left, right: _right}) do
    monad %State{} do
      # Exercise. Fill here
      return :place_holder
    end
  end

  def label_post_order(nil) do
    monad %State{} do
      # Exercise. Fill here
      return :place_holder
    end
  end
end
