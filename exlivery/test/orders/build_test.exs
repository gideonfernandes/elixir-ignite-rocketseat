defmodule Exlivery.Orders.BuildTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Items.Build, as: BuildItem
  alias Exlivery.Orders.Build

  describe "call/0" do
    test "returns an empty Order struct" do
      expected_response =
        build(:order, delivery_address: nil, items: nil, total_price: nil, user_cpf: nil)

      response = Build.call()

      assert response == expected_response
    end
  end

  describe "call/1" do
    test "returns a builded Order with symbol map keys" do
      {:ok, item} = BuildItem.call(:dessert, "Bolo de Morango", 10, Decimal.new("25.50"))

      expected_response = {:ok, build(:order, total_price: Decimal.new("255.00"))}

      response =
        Build.call(%{
          delivery_address: "Rua dos Morango, 1740",
          items: [item],
          user_cpf: "999.999.999-99"
        })

      assert response == expected_response
    end

    test "returns a builded Order with string map keys" do
      {:ok, item} = BuildItem.call(:dessert, "Bolo de Morango", 10, Decimal.new("25.50"))

      expected_response = {:ok, build(:order, total_price: Decimal.new("255.00"))}

      response =
        Build.call(%{
          "delivery_address" => "Rua dos Morango, 1740",
          "items" => [item],
          "user_cpf" => "999.999.999-99"
        })

      assert response == expected_response
    end

    test "returns an error if the map is invalid" do
      expected_response = {:error, :invalid_args}

      response = Build.call(%{})

      assert response == expected_response
    end
  end

  describe "call/3" do
    test "returns a builded Order" do
      {:ok, item1} = BuildItem.call(:dessert, "Bolo de Cenoura", 3, Decimal.new("30"))
      {:ok, item2} = BuildItem.call(:dessert, "Bolo de Chocolate", 2, Decimal.new("50.60"))

      items = [item1, item2]

      expected_response = {:ok, build(:order, items: items, total_price: Decimal.new("191.20"))}

      response = Build.call("Rua dos Morango, 1740", items, "999.999.999-99")

      assert response == expected_response
    end

    test "returns an error if items list is empty" do
      expected_response = {:error, :invalid_args}

      response = Build.call("Rua dos Morango, 1740", [], "999.999.999-99")

      assert response == expected_response
    end
  end
end
