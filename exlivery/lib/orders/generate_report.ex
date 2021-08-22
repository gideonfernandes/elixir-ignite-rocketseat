defmodule Exlivery.Orders.GenerateReport do
  alias Exlivery.Orders.Order
  alias Exlivery.Orders.Items.Item

  def call(filename) do
    File.write(filename, report_content())
  end

  defp report_content do
    Exlivery.orders()
    |> Map.values()
    |> Enum.map(&build_order_string/1)
  end

  defp build_order_string(%Order{items: items, total_price: total_price, user_cpf: user_cpf}) do
    "#{user_cpf}, #{Enum.map(items, &build_item_string/1)}#{total_price}\n"
  end

  defp build_item_string(%Item{
         category: category,
         description: description,
         quantity: quantity,
         unit_price: unit_price
       }) do
    "#{category}, #{description}, #{quantity}, #{unit_price}, "
  end
end
