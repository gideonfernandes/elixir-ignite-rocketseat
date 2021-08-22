defmodule Exlivery.Users.BuildTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Build

  describe "call/0" do
    test "returns an empty User struct" do
      expected_response = build(:user, address: nil, age: nil, cpf: nil, email: nil, name: nil)

      response = Build.call()

      assert response == expected_response
    end
  end

  describe "call/1" do
    test "returns a builded User with symbol map keys" do
      expected_response = {:ok, build(:user)}

      response =
        build(:user)
        |> Build.call()

      assert response == expected_response
    end

    test "returns a builded User with string map keys" do
      expected_response = {:ok, build(:user)}

      response =
        build(:user_params)
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
    test "returns a builded User" do
      expected_response = {:ok, build(:user)}

      response =
        build(:user_params)
        |> Build.call()

      assert response == expected_response
    end

    test "returns an error if age is less than 18" do
      expected_response = {:error, :invalid_args}

      response =
        build(:user, age: 17)
        |> Build.call()

      assert response == expected_response
    end
  end
end
