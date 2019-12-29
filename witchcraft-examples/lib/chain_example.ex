defmodule ChainExample do
  use Witchcraft

  import Witchcraft.Chain

  def one do
    chain([1, 2, 3], fn x ->
      chain([x + 1], fn y ->
        chain([y + 2, y + 10], fn z ->
          [x, y, z]
        end)
      end)
    end)
  end

  def two do
    f = fn x ->
      chain([x + 1], fn y ->
        chain([y + 2, y + 10], fn z ->
          [x, y, z]
        end)
      end)
    end

    {chain([1, 2, 3], f), f}
  end

  def thr do
    [1, 2, 3]
    |> chain(fn x -> [x + 1] end)
    |> chain(fn x -> [x + 2, x + 10] end)
  end
end
