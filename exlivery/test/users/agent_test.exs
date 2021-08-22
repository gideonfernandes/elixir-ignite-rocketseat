defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.{Agent, User}

  setup do
    Agent.start_link(%{})

    :ok
  end

  describe "get/1" do
    test "returns an existing user" do
      expected_response =
        {:ok,
         %User{
           address: "Rua dos Morango, 1740",
           age: 23,
           cpf: "999.999.999-99",
           email: "gideonfernandes@gmail.com",
           name: "Gideon Fernandes"
         }}

      {:ok, user_cpf} = Agent.save(build(:user))

      response = Agent.get(user_cpf)

      assert response == expected_response
    end

    test "returns an error if user does not exist" do
      expected_response = {:error, :user_not_found}

      response = Agent.get("123456789")

      assert response == expected_response
    end
  end

  describe "save/1" do
    test "must create a new user" do
      new_user = build(:user)

      expected_response = {:ok, new_user.cpf}

      response = Agent.save(new_user)

      assert response == expected_response
    end

    test "must update an existing user" do
      {:ok, user_cpf} =
        build(:user)
        |> Agent.save()

      {:ok, user} = Agent.get(user_cpf)

      Agent.save(%{user | name: "Herika Fernandes"})

      expected_response = %User{
        address: "Rua dos Morango, 1740",
        age: 23,
        cpf: "999.999.999-99",
        email: "gideonfernandes@gmail.com",
        name: "Herika Fernandes"
      }

      {:ok, response} = Agent.get(user_cpf)

      assert response == expected_response
    end
  end
end
