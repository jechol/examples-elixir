defmodule Example.StateTreeLabeler do
  use Witchcraft

  alias Algae.State
  alias Example.Tree

  import Algae.State
  import Witchcraft.Monad

  def rank_post_order(%Tree{left: left, right: right}) do
    monad %State{} do
      labeled_left <- rank_post_order(left)
      labeled_right <- rank_post_order(right)

      rank <- get()
      modify fn r -> r + 1 end

      return %Tree{data: rank, left: labeled_left, right: labeled_right}
    end
  end

  def rank_post_order(nil) do
    monad %State{} do
      return nil
    end
  end
end
