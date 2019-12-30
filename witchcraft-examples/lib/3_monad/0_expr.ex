defmodule Seminar.Monad.Expr do
  import Algae

  # Data type to be used in examples.

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
