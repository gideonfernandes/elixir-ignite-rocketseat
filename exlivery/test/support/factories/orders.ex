defmodule Exlivery.Factories.Orders do
  import Exlivery.Factory

  alias Exlivery.Orders.Order

  def order do
    %Order{
      delivery_address: "Rua dos Morango, 1740",
      items: [build(:item)],
      total_price: Decimal.new("25.50"),
      user_cpf: "999.999.999-99"
    }
  end
end
