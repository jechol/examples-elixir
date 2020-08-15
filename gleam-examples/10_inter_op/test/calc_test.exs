defmodule CalcTest do
  use ExUnit.Case

  test "ElixirCalc" do
    assert ElixirCalc.add(1, 2) == 3
    assert ElixirCalc.call_erlang_add(1, 2) == 3
    assert ElixirCalc.call_gleam_add(1, 2) == 3
  end

  test ":erlang_calc" do
    assert :erlang_calc.add(1, 2) == 3
    assert :erlang_calc.call_elixir_add(1, 2) == 3
    assert :erlang_calc.call_gleam_add(1, 2) == 3
  end

  test ":gleam_calc" do
    assert :gleam_calc.add(1, 2) == 3
    assert :gleam_calc.call_elixir_add(1, 2) == 3
    assert :gleam_calc.call_erlang_add(1, 2) == 3
  end
end
