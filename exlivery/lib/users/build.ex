defmodule Exlivery.Users.Build do
  alias Exlivery.Users.User

  def call, do: %User{address: nil, age: nil, cpf: nil, email: nil, name: nil}

  def call(address, age, cpf, email, name) when age >= 18 and is_bitstring(cpf) do
    user =
      call()
      |> address(address)
      |> age(age)
      |> cpf(cpf)
      |> email(email)
      |> name(name)

    {:ok, user}
  end

  def call(_address, _age, _cpf, _email, _name), do: {:error, :invalid_args}

  def call(%User{address: address, age: age, cpf: cpf, email: email, name: name}) do
    call(address, age, cpf, email, name)
  end

  def call(%{"address" => address, "age" => age, "cpf" => cpf, "email" => email, "name" => name}) do
    call(address, age, cpf, email, name)
  end

  def call(_args), do: {:error, :invalid_args}

  def address(user, address), do: %{user | address: address}

  def age(user, age), do: %{user | age: age}

  def cpf(user, cpf), do: %{user | cpf: cpf}

  def email(user, email), do: %{user | email: email}

  def name(user, name), do: %{user | name: name}
end
