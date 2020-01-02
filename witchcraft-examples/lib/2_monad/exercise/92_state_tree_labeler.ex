defmodule Example.StateTreeLabeler do
  use Witchcraft

  alias Algae.State
  alias Example.Tree

  import Algae.State
  import Witchcraft.Monad

  # New macros available in `State` monad,
  #
  # 4. get() : {state, state} (Copies state to value so that `<-` binds to state)
  # 5. put(new_state) : {value, new_state}
  # 6. modify(fun) : {value, fun.(state)}

  def label_post_order(%Tree{left: left, right: right}) do
    monad %State{} do
      labeled_left <- label_post_order(left)
      labeled_right <- label_post_order(right)

      label <- get()

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
