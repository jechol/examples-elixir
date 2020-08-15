defmodule InterOpTest do
  use ExUnit.Case
  doctest InterOp

  test "greets the world" do
    assert InterOp.hello() == :world
  end
end
