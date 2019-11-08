defmodule WcStudyTest do
  use ExUnit.Case
  doctest WcStudy

  test "greets the world" do
    assert WcStudy.hello() == :world
  end
end
