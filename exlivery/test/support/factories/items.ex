defmodule Exlivery.Factories.Items do
  alias Exlivery.Orders.Items.Item

  def item do
    %Item{
      category: :dessert,
      description: "Bolo de Morango",
      quantity: 10,
      unit_price: Decimal.new("25.50")
    }
  end

  def item_params do
    %{
      "category" => :dessert,
      "description" => "Bolo de Morango",
      "quantity" => 10,
      "unit_price" => "25.50"
    }
  end
end
