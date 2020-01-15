defmodule DoNotationTest do
  use ExUnit.Case

  require DoNotation

  test "do_notation" do
    from_ast =
      quote do
        a_val <- eval(a)
        b_val <- eval(b)
        safe_div(a_val, b_val)
      end

    to_ast =
      quote do
        eval(a)
        |> Bind.bind(fn a_val ->
          eval(b)
          |> Bind.bind(fn b_val ->
            safe_div(a_val, b_val)
          end)
        end)
      end

    converted_ast = DoNotation.convert_ast(from_ast)

    assert Macro.to_string(converted_ast) == Macro.to_string(to_ast)
  end
end
