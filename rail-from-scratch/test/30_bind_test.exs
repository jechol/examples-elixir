defmodule MaybeBindTest do
  use ExUnit.Case

  import Bind

  def inc(n), do: {:ok, n + 1}

  test "ok" do
    assert {:ok, 1} |> bind(&inc/1) == {:ok, 2}

    assert {:ok, 1}
           |> bind(&inc/1)
           |> bind(&inc/1) ==
             {:ok, 3}
  end

  test "error" do
    assert {:error, :div_by_zero} |> bind(&inc/1) == {:error, :div_by_zero}
  end
end
