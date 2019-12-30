defmodule Seminar.Adt.Expr do
  import Algae

  # Expr is data type to be used in examples.
  # Neither functor nor monad.

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
