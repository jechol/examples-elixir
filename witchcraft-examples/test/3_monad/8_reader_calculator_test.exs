# demdefmodule Seminar.Monad.ReaderCalculator do
#   use ExUnit.Case
#   use Witchcraft

#   alias Seminar.Monad.Expr.{Val, Div}
#   alias Seminar.Monad.Reader, as: C

#   test "success cases" do
#     assert C.eval(1) == {:ok, 1}
#     assert C.eval({:+, 1, 2}) == {:ok, 3}
#     assert C.eval({:-, {:+, 10, 5}, 2}) == {:ok, 13}
#     assert C.eval({:/, 10, 2}) == {:ok, 5}
#     assert C.eval({:/, 10, 0}) == {:error, :div_by_zero}
#   end
# end
