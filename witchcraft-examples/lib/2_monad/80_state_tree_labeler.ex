defmodule Example.StateTreeLabeler do
  use Witchcraft

  alias Algae.State
  alias Example.Tree

  import Algae.State
  import Witchcraft.Monad

  def label_post_order(%Tree{left: left, right: right}) do
    monad %State{} do
      # We don't need to pass state.
      labeled_left <- label_post_order(left)
      labeled_right <- label_post_order(right)

      label <- get()
      # same with `put(label + 1)`
      modify fn r -> r + 1 end

      return %Tree{data: label, left: labeled_left, right: labeled_right}
    end
  end

  def label_post_order(nil) do
    monad %State{} do
      return nil
    end
  end
end
