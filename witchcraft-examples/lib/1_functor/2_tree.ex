import TypeClass

defmodule Example.Tree do
  import Algae

  # Product type to be used in the following examples.

  defdata do
    data :: integer()
    left :: any()
    right :: any()
  end
end

alias Example.Tree

defimpl TypeClass.Property.Generator, for: Tree do
  def generate(_) do
    # Used to check Tree meets Functor property, e.g. left identity.
    # tree = TypeClass.Property.Generator.
    # Functor.map()
    Tree.new(10, Tree.new(20), Tree.new(30))
  end
end

definst Witchcraft.Functor, for: Tree do
  def map(%Tree{data: data, left: left, right: right}, fun) do
    %Tree{
      data: fun.(data),
      left: if(left == nil, do: nil, else: map(left, fun)),
      right: if(right == nil, do: nil, else: map(right, fun))
    }
  end
end
