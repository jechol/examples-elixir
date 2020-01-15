defmodule DoNotationTest do
  use ExUnit.Case

  require DoNotation

  test "do_notation" do
    from =
      quote do
        a_val <- eval(a)
        b_val <- eval(b)
        safe_div(a_val, b_val)
      end

    to =
      quote do
        eval(a)
        |> Bind.bind(fn a_val ->
          eval(b)
          |> Bind.bind(fn b_val ->
            safe_div(a_val, b_val)
          end)
        end)
      end

    converted = DoNotation.convert_ast(from)

    assert Macro.to_string(converted) == Macro.to_string(to)
  end
end
