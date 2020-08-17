import gleam/int

pub fn some_math(a, b, c) {
  let _ = { a + b } * c

  // ( a + b ) * c is syntax error here.

  // ( ) is used only for function invocation,
  // because there are no significant white spaces in gleam
  // that following expressions are not distinguishable.

  int.to_string
  (a + b)

  int.to_string(a + b)
}