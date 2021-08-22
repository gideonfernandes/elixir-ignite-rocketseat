defmodule Exlivery.Users.IndexTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.{Agent, Index, User}

  setup do
    Agent.start_link(%{})

    :ok
  end

  describe "call/0" do
    test "returns the users" do
      Enum.each(
        [build(:user), build(:user, cpf: "12345678910"), build(:user, cpf: "12345678911")],
        &Agent.save/1
      )

      expected_response = %{
        "12345678910" => %User{
          address: "Rua dos Morango, 1740",
          age: 23,
          cpf: "12345678910",
          email: "gideonfernandes@gmail.com",
          name: "Gideon Fernandes"
        },
        "12345678911" => %User{
          address: "Rua dos Morango, 1740",
          age: 23,
          cpf: "12345678911",
          email: "gideonfernandes@gmail.com",
          name: "Gideon Fernandes"
        },
        "999.999.999-99" => %User{
          address: "Rua dos Morango, 1740",
          age: 23,
          cpf: "999.999.999-99",
          email: "gideonfernandes@gmail.com",
          name: "Gideon Fernandes"
        }
      }

      response = Index.call()

      assert response == expected_response
    end
  end
end
