defmodule Exlivery.Orders.Order do
  @keys [:delivery_address, :items, :total_price, :user_cpf]

  @enforce_keys @keys

  defstruct @keys
end
