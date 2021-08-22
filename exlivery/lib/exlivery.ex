defmodule Exlivery do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Get, as: GetOrder
  alias Exlivery.Orders.GenerateReport
  alias Exlivery.Orders.Index, as: IndexOrders
  alias Exlivery.Orders.Save, as: SaveOrder
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.Get, as: GetUser
  alias Exlivery.Users.Index, as: IndexUsers
  alias Exlivery.Users.Save, as: SaveUser

  def start_agents do
    OrderAgent.start_link(%{})
    UserAgent.start_link(%{})
  end

  defdelegate get_order(id), to: GetOrder, as: :call
  defdelegate generate_report(filename \\ "report.csv"), to: GenerateReport, as: :call
  defdelegate orders, to: IndexOrders, as: :call
  defdelegate save_order(params), to: SaveOrder, as: :call
  defdelegate get_user(cpf), to: GetUser, as: :call
  defdelegate save_user(params), to: SaveUser, as: :call
  defdelegate users, to: IndexUsers, as: :call
end
