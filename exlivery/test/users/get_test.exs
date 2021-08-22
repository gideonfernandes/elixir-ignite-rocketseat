defmodule Exlivery.Users.GetTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.{Agent, Get, User}

  setup do
    Agent.start_link(%{})

    :ok
  end

  describe "call/1" do
    test "returns an existing user" do
      {:ok, id} = Agent.save(build(:user))

      expected_response =
        {:ok,
         %User{
           address: "Rua dos Morango, 1740",
           age: 23,
           cpf: "999.999.999-99",
           email: "gideonfernandes@gmail.com",
           name: "Gideon Fernandes"
         }}

      response = Get.call(id)

      assert response == expected_response
    end

    test "returns an error if user does not exist" do
      expected_response = {:error, :user_not_found}

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
