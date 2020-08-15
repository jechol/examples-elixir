import gleam_calc
import gleam/should

pub fn add_test() {
  gleam_calc.add(1, 2)
  |> should.equal(3)
}

pub fn call_elixir_add_test() {
  gleam_calc.call_elixir_add(1, 2)
  |> should.equal(3)
}

pub fn call_erlang_add_test() {
  gleam_calc.call_erlang_add(1, 2)
  |> should.equal(3)
}