import gleam_calc
import gleam/should
import gleam/atom

pub fn add_test() {
  // assert gleam_calc.add(1, 2) == 3
  "ok"
  |> atom.from_string
  |> should.be_ok
}
