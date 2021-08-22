defmodule Exlivery.Orders.Save do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Build, as: BuildOrder
  alias Exlivery.Orders.Items.Build, as: BuildItem
  alias Exlivery.Orders.Items.Item
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  def call(%{"user_cpf" => user_cpf, "items" => items}) do
    with {:ok, %User{address: address}} <- UserAgent.get(user_cpf),
         {:ok, builded_items} <- build_items(items),
         {:ok, order} <-
           BuildOrder.call(%{
             "delivery_address" => address,
             "items" => builded_items,
             "user_cpf" => user_cpf
           }) do
      OrderAgent.save(order)
    end
  end

  def call(_), do: {:error, :invalid_args}

  defp build_items(items) do
    items
    |> Enum.map(&try_build_item/1)
    |> handle_builded_items()
  end

  defp try_build_item(item_params) do
    case BuildItem.call(item_params) do
      {:ok, %Item{} = item} -> item
      {:error, _reason} = error -> error
    end
  end

  defp handle_builded_items(items) do
    if Enum.all?(items, &is_struct/1), do: {:ok, items}, else: {:error, :invalid_items}
  end
end
