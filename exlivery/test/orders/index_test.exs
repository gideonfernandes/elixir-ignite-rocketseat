defmodule Exlivery.Orders.IndexTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.{Agent, Index}

  setup do
    Agent.start_link(%{})

    :ok
  end

  describe "call/0" do
    test "returns the orders" do
      builded_orders = [build(:order), build(:order), build(:order)]

      order_ids =
        builded_orders
        |> Enum.map(&Agent.save/1)
        |> Enum.map(fn {:ok, id} -> id end)

      expected_response = link_ids_with_orders(order_ids, builded_orders)

      response = Index.call()

      assert response == expected_response
    end
  end

  defp link_ids_with_orders(order_ids, builded_orders) do
    %{}
    |> Map.put(Enum.fetch!(order_ids, 0), Enum.fetch!(builded_orders, 0))
    |> Map.put(Enum.fetch!(order_ids, 1), Enum.fetch!(builded_orders, 1))
    |> Map.put(Enum.fetch!(order_ids, 2), Enum.fetch!(builded_orders, 2))
  end
end
