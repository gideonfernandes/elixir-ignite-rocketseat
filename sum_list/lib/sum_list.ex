defmodule SumList do
  def call(list), do: do_sum(list, 0)

  defp do_sum([], acc), do: acc
  defp do_sum([head | tail], acc), do: do_sum(tail, acc + head)
end
