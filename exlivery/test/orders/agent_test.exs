defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.{Agent, Order}
  alias Exlivery.Orders.Items.Item

  setup do
    Agent.start_link(%{})

    :ok
  end

  describe "get/1" do
    test "returns an existing order" do
      expected_response =
        {:ok,
         %Order{
           delivery_address: "Rua dos Morango, 1740",
           items: [
             %Item{
               category: :dessert,
               description: "Bolo de Morango",
               quantity: 10,
               unit_price: Decimal.new("25.50")
             }
           ],
           total_price: Decimal.new("25.50"),
           user_cpf: "999.999.999-99"
         }}

      {:ok, id} = Agent.save(build(:order))

      response = Agent.get(id)

      assert response == expected_response
    end

    test "returns an error if order does not exist" do
      expected_response = {:error, :order_not_found}

      response = Agent.get("123456789")

      assert response == expected_response
    end
  end

  describe "save/1" do
    test "must create a new order" do
      new_order = build(:order)

      response = Agent.save(new_order)

      assert {:ok, _id} = response
    end

    test "must update an existing order" do
      {:ok, id} =
        build(:order)
        |> Agent.save()

      {:ok, order} = Agent.get(id)

      Agent.save(%{order | delivery_address: "Rua dos Abacate, 1741"})

      expected_response = %Order{
        delivery_address: "Rua dos Morango, 1740",
        items: [
          %Item{
            category: :dessert,
            description: "Bolo de Morango",
            quantity: 10,
            unit_price: Decimal.new("25.50")
          }
        ],
        total_price: Decimal.new("25.50"),
        user_cpf: "999.999.999-99"
      }

      {:ok, response} = Agent.get(id)

      assert response == expected_response
    end
  end
end
