import TypeClass

defmodule Tx do
  defstruct [:txid, :block_no]
end

defimpl TypeClass.Property.Generator, for: Tx do
  def generate(_data) do
    txid = :rand.uniform(10)
    block_no = :rand.uniform(10)
    %Tx{txid: txid, block_no: block_no}
  end
end

definst Witchcraft.Setoid, for: Tx do
  @spec equivalent?(atom | %{txid: any}, atom | %{txid: any}) :: boolean
  def equivalent?(a, b) do
    a.txid == b.txid
  end
end
