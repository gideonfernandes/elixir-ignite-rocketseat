defmodule Exlivery.Orders.Agent do
  use Agent

  alias Exlivery.Orders.Order

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(id), do: Agent.get(__MODULE__, &do_get(&1, id))
  def index, do: Agent.get(__MODULE__, & &1)

  def save(%Order{} = order) do
    id = UUID.uuid4()

    Agent.update(__MODULE__, &Map.put(&1, id, order))

    {:ok, id}
  end

  defp do_get(state, id) do
    case Map.get(state, id) do
      nil -> {:error, :order_not_found}
      order -> {:ok, order}
    end
  end
end
