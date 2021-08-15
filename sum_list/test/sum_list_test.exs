defmodule SumListTest do
  use ExUnit.Case

  describe "call/1" do
    test "returns 0 if the list is empty", do: assert SumList.call([]) == 0
    test "returns the list sum", do: assert SumList.call([1, 2, 10, 120]) == 133
  end
end
