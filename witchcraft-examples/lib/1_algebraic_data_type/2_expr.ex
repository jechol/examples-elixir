defmodule Seminar.Adt.Expr do
  import Algae

  defsum do
    defdata Val do
      val :: integer()
    end

    defdata Div do
      num :: integer()
      denom :: integer()
    end
  end
end
