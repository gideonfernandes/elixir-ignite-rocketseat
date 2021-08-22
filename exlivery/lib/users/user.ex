defmodule Exlivery.Users.User do
  @keys [:address, :age, :cpf, :email, :name]

  @enforce_keys @keys

  defstruct @keys
end
