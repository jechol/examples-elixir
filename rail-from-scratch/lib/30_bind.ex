defmodule Bind do
  def bind(tuple, func) do
    case tuple do
      {:error, _} = e -> e
      {:ok, data} -> func.(data)
    end
  end
end
