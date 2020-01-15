defmodule DoNotation do
  defmacro bind(do: block) do
    block |> convert_ast()
  end

  def convert_ast(block) do
    {:__block__, [], exprs} = block

    exprs
    |> Enum.reverse()
    |> Enum.reduce(fn
      {:<-, _, [left, right]}, acc ->
        quote context: Elixir do
          unquote(right) |> Bind.bind(fn unquote(left) -> unquote(acc) end)
        end
    end)

    # Above Enum.reduce() works like following.
    #
    # 1. elem : b_val <- eval(b)
    #    acc  : safe_div(a_val, b_val)
    # => eval(b) |> Bind.bind(fn b_val -> safe_div(a_val, b_val) end)
    #
    # 2. elem : a_val <- eval(a)
    #    acc  : eval(b) |> Bind.bind(fn b_val -> safe_div(a_val, b_val) end)
    # => eval(a) |> Bind.bind(fn a_val -> eval(b) |> Bind.bind(fn b_val -> safe_div(a_val, b_val) end) end)
  end

  def example_from do
    # {:__block__, [],
    #  [
    #    {:<-, [], [{:a_val, [], DoNotation}, {:eval, [], [{:a, [], DoNotation}]}]},
    #    {:<-, [], [{:b_val, [], DoNotation}, {:eval, [], [{:b, [], DoNotation}]}]},
    #    {:safe_div, [], [{:a_val, [], DoNotation}, {:b_val, [], DoNotation}]}
    #  ]}
    quote do
      a_val <- eval(a)
      b_val <- eval(b)
      safe_div(a_val, b_val)
    end
  end

  def example_to do
    quote do
      eval(a)
      |> Bind.bind(fn a_val ->
        eval(b)
        |> Bind.bind(fn b_val ->
          safe_div(a_val, b_val)
        end)
      end)
    end
  end
end
