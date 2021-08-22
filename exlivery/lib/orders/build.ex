defmodule Exlivery.Orders.Build do
  alias Exlivery.Orders.Items.Item
  alias Exlivery.Orders.Order

  def call, do: %Order{delivery_address: nil, items: nil, total_price: nil, user_cpf: nil}

  def call(delivery_address, [%Item{} | _tail] = items, user_cpf) do
    calculated_total_price = calculate_total_price(items)

    order =
      call()
      |> delivery_address(delivery_address)
      |> items(items)
      |> total_price(calculated_total_price)
      |> user_cpf(user_cpf)

    {:ok, order}
  end

  def call(_delivery_address, _items, _user_cpf), do: {:error, :invalid_args}

  def call(%{delivery_address: delivery_address, items: items, user_cpf: user_cpf}) do
    call(delivery_address, items, user_cpf)
  end

  def call(%{"delivery_address" => delivery_address, "items" => items, "user_cpf" => user_cpf}) do
    call(delivery_address, items, user_cpf)
  end

  def call(_args), do: {:error, :invalid_args}

  def delivery_address(order, delivery_address), do: %{order | delivery_address: delivery_address}

  def items(order, items), do: %{order | items: items}

  defp calculate_total_price(items) do
    Enum.reduce(items, Decimal.new("0.00"), &sum_prices(&1, &2))
  end

  defp sum_prices(%Item{quantity: quantity, unit_price: unit_price}, acc) do
    unit_price
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end

  def total_price(order, total_price), do: %{order | total_price: total_price}

  def user_cpf(order, user_cpf), do: %{order | user_cpf: user_cpf}
end
