defmodule Exlivery.Orders.Get do
  alias Exlivery.Orders.Agent, as: OrderAgent

  def call(id) when is_bitstring(id) do
    OrderAgent.get(id)
  end

  def call(_), do: {:error, :invalid_arg}
end
