defmodule Exlivery.Orders.Items.Build do
  alias Exlivery.Orders.Items.Item

  @categories [:dessert, :dish_made, :hamburguer, :japonese, :meat, :pizza]

  def call, do: %Item{category: nil, description: nil, quantity: nil, unit_price: nil}

  def call(category, description, quantity, unit_price)
      when category in @categories and quantity > 0 do
    unit_price
    |> Decimal.cast()
    |> do_build(category, description, quantity)
  end

  def call(_category, _description, _quantity, _unit_price), do: {:error, :invalid_args}

  def call(%{
        "category" => category,
        "description" => description,
        "quantity" => quantity,
        "unit_price" => unit_price
      }) do
    call(category, description, quantity, unit_price)
  end

  def call(%Item{
        category: category,
        description: description,
        quantity: quantity,
        unit_price: unit_price
      }) do
    call(category, description, quantity, unit_price)
  end

  def call(_args), do: {:error, :invalid_args}

  defp do_build({:ok, casted_unit_price}, category, description, quantity) do
    item =
      call()
      |> category(category)
      |> description(description)
      |> quantity(quantity)
      |> unit_price(casted_unit_price)

    {:ok, item}
  end

  defp do_build(:error, _category, _description, _quantity), do: {:error, :invalid_args}

  def category(item, category), do: %{item | category: category}

  def description(item, description), do: %{item | description: description}

  def quantity(item, quantity), do: %{item | quantity: quantity}

  def unit_price(item, unit_price), do: %{item | unit_price: unit_price}
end
