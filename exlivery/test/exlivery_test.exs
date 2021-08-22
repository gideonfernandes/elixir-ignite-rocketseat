defmodule ExliveryTest do
  use ExUnit.Case

  test "start_agents/0" do
    response = Exlivery.start_agents()

    assert {:ok, _pid} = response
  end
end
