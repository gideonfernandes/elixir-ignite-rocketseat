defmodule Exlivery.Factories.Users do
  alias Exlivery.Users.User

  def user do
    %User{
      address: "Rua dos Morango, 1740",
      age: 23,
      cpf: "999.999.999-99",
      email: "gideonfernandes@gmail.com",
      name: "Gideon Fernandes"
    }
  end

  def user_params do
    %{
      "address" => "Rua dos Morango, 1740",
      "age" => 23,
      "cpf" => "999.999.999-99",
      "email" => "gideonfernandes@gmail.com",
      "name" => "Gideon Fernandes"
    }
  end
end
