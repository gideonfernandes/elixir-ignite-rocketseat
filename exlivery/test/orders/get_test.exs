defmodule Exlivery.Orders.GetTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.{Agent, Get, Order}
  alias Exlivery.Orders.Items.Item

  setup do
    Agent.start_link(%{})

    :ok
  end

  describe "call/1" do
    test "returns an existing order" do
      {:ok, id} = Agent.save(build(:order))

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

      response = Get.call(id)

      assert response == expected_response
    end

    test "returns an error if order does not exist" do
      expected_response = {:error, :order_not_found}

      response = Get.call("123456789")

      assert response == expected_response
    end

    test "returns an error if an invalid param is provided" do
      expected_response = {:error, :invalid_arg}

      response = Get.call(30)

      assert response == expected_response
    end
  end
end
