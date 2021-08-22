defmodule Exlivery.Orders.Items.Item do
  @keys [:category, :description, :quantity, :unit_price]

  @enforce_keys @keys

  defstruct @keys
end
