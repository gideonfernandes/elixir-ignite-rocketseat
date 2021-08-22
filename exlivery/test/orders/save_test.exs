defmodule Exlivery.Orders.SaveTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Save
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Exlivery.start_agents()

      {:ok, user_cpf} =
        build(:user)
        |> UserAgent.save()

      order_params = %{"user_cpf" => user_cpf, "items" => build_list(2, :item_params)}

      {:ok, order_params: order_params}
    end

    test "must save an order", %{order_params: order_params} do
      response = Save.call(order_params)

      assert {:ok, _id} = response
    end

    test "returns an error if invalid parameters are given", %{order_params: order_params} do
      order_params = %{order_params | "items" => []}

      expected_response = {:error, :invalid_args}

      response = Save.call(order_params)

      assert response == expected_response
    end

    test "returns an error if the user is not found", %{order_params: order_params} do
      order_params = %{order_params | "user_cpf" => "12345678910"}

      expected_response = {:error, :user_not_found}

      response = Save.call(order_params)

      assert response == expected_response
    end
  end
end
