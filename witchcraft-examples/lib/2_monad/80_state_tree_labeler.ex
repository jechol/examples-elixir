defmodule Example.StateTreeLabeler do
  use Witchcraft

  alias Algae.State
  alias Example.Tree

  import Algae.State
  import Witchcraft.Monad

  def label_post_order(%Tree{left: left, right: right}) do
    # Macros available in `Writer` monad,
    #
    # 4. get() : Returns a monad that set value as state.
    # 5. put(new_state) : Returns a monad that set new_state as state.
    # 6. modify(fun) : Return a monad that runs `fun` on state.
    monad %State{} do
      # We don't need to pass state.
      labeled_left <- label_post_order(left)
      labeled_right <- label_post_order(right)

      # `get()` returns {state, state}
      # and label <- {val, state} binds label as val.
      label <- get()

      # same with `put(label + 1)` because label is set to state.
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
