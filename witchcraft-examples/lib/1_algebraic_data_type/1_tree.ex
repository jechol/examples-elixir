defmodule Seminar.Adt.Tree do
  import Algae

  defdata do
    data :: integer()
    left :: any()
    right :: any()
  end
end
