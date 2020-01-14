defmodule MaybeBind do
  alias Maybe.{Just, Nothing}

  def bind(maybe, func) do
    case maybe do
      %Nothing{} -> %Nothing{}
      %Just{just: data} -> func.(data)
    end
  end
end
