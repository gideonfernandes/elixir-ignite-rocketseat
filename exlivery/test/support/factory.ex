defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Factories.Items, as: ItemFactories
  alias Exlivery.Factories.Orders, as: OrderFactories
  alias Exlivery.Factories.Users, as: UserFactories

  defdelegate item_factory, to: ItemFactories, as: :item
  defdelegate item_params_factory, to: ItemFactories, as: :item_params
  defdelegate order_factory, to: OrderFactories, as: :order
  defdelegate user_factory, to: UserFactories, as: :user
  defdelegate user_params_factory, to: UserFactories, as: :user_params
end
