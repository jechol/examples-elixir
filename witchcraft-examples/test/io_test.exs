defmodule IOTest do
  use ExUnit.Case

  test "hello" do
    answer = IO.gets("yes or no: ") |> String.trim()
    assert answer == "yes"
  end
end
