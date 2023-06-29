defmodule Maybe do
  defmodule Just do
    defstruct [:just]

    def new(val), do: %Just{just: val}
  end

  defmodule Nothing do
    defstruct []

    def new(), do: %Nothing{}
  end
end
