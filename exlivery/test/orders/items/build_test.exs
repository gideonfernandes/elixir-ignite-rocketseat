defmodule Exlivery.Orders.Items.BuildTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Items.Build

  describe "call/0" do
    test "returns an empty Item struct" do
      expected_response =
        build(:item, category: nil, description: nil, quantity: nil, unit_price: nil)

      response = Build.call()

      assert response == expected_response
    end
  end

  describe "call/1" do
    test "returns a builded Item with symbol map keys" do
      expected_response = {:ok, build(:item)}

      response =
        build(:item)
        |> Build.call()

      assert response == expected_response
    end

    test "returns a builded Item with string map keys" do
      expected_response = {:ok, build(:item)}

      response =
        build(:item_params)
        |> Build.call()

      assert response == expected_response
    end

    test "returns an error if the map is invalid" do
      expected_response = {:error, :invalid_args}

      response = Build.call(%{})

      assert response == expected_response
    end
  end

  describe "call/3" do
    test "returns a builded Item" do
      expected_response = {:ok, build(:item)}

      response = Build.call(:dessert, "Bolo de Morango", 10, "25.50")

      assert response == expected_response
    end

    test "returns an error if the category is invalid" do
      expected_response = {:error, :invalid_args}

      response = Build.call(:invalid, "Bolo de Morango", 10, "25.50")

      assert response == expected_response
    end

    test "returns an error if the quantity is invalid" do
      expected_response = {:error, :invalid_args}

      response = Build.call(:dessert, "Bolo de Morango", 0, "25.50")

      assert response == expected_response
    end
  end
end
