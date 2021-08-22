defmodule Exlivery.Users.Get do
  alias Exlivery.Users.Agent, as: UserAgent

  def call(cpf) when is_bitstring(cpf) do
    UserAgent.get(cpf)
  end

  def call(_), do: {:error, :invalid_arg}
end
