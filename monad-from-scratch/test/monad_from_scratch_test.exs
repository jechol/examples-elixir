defmodule MonadFromScratchTest do
  use ExUnit.Case
  doctest MonadFromScratch

  test "greets the world" do
    assert MonadFromScratch.hello() == :world
  end
end
