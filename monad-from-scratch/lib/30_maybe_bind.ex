defmodule MaybeBind do
  use Operator

  alias Maybe.{Just, Nothing}

  def bind(%Nothing{}, _func) do
    %Nothing{}
  end

  def bind(%Just{just: data}, func) do
    func.(data)
  end

  defalias expr >>> bind_func, as: :bind
end
