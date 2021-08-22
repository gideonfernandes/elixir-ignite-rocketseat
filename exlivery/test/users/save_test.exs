defmodule Exlivery.Users.SaveTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Save

  describe "call/1" do
    setup do
      Exlivery.start_agents()

      :ok
    end

    test "must save an order" do
      user_params = build(:user_params)

      response = Save.call(user_params)

      assert {:ok, _id} = response
    end

    test "returns an error if invalid parameters are given" do
      user_params =
        build(:user_params)
        |> Map.delete("age")

      expected_response = {:error, :invalid_args}

      response = Save.call(user_params)

      assert response == expected_response
    end
  end
end
