defmodule ElixirCalc do
  def add(a, b) do
    a + b
  end

  def call_gleam_add(a, b) do
    :gleam_calc.add(a, b)
  end

  def call_erlang_add(a, b) do
    :erlang_calc.add(a, b)
  end
end
