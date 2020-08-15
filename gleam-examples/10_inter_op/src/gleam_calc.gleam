external fn elixir_add(a: Int, b: Int) -> Int =
  "Elixir.ElixirCalc" "add"

external fn erlang_add(a: Int, b: Int) -> Int =
  "erlang_calc" "add"

pub fn add(a, b) {
  a + b
}

pub fn call_elixir_add(a, b) {
  elixir_add(a, b)
}

pub fn call_erlang_add(a, b) {
  erlang_add(a, b)
}
