defmodule Exlivery.Users.Index do
  alias Exlivery.Users.Agent, as: UserAgent

  def call, do: UserAgent.index()
end
