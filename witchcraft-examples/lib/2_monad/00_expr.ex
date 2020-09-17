defmodule Example.Expr do
  import Algae

  # Sum type of Val and Div to be used in following examples.

  defsum do
    defdata Val do
      val :: number()
    end

    defdata Div do
      num :: number()
      denom :: number()
    end
  end
end
