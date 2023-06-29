defmodule Expr do
  defmodule Val do
    defstruct [:val]

    def new(val), do: %Val{val: val}
  end

  defmodule Div do
    defstruct [:num, :denom]

    def new(num, denom), do: %Div{num: num, denom: denom}
  end
end
