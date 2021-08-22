defmodule Exlivery.Orders.Index do
  alias Exlivery.Orders.Agent, as: OrderAgent

  def call, do: OrderAgent.index()
end
