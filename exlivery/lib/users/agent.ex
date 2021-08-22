defmodule Exlivery.Users.Agent do
  use Agent

  alias Exlivery.Users.User

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(cpf), do: Agent.get(__MODULE__, &do_get(&1, cpf))
  def index, do: Agent.get(__MODULE__, & &1)
  def save(%User{cpf: cpf} = user), do: {Agent.update(__MODULE__, &Map.put(&1, cpf, user)), cpf}

  defp do_get(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, :user_not_found}
      user -> {:ok, user}
    end
  end
end
