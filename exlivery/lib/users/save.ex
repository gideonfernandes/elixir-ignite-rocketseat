defmodule Exlivery.Users.Save do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User
  alias Exlivery.Users.Build, as: UserBuild

  def call(user_params) do
    user_params
    |> UserBuild.call()
    |> do_save()
  end

  defp do_save({:ok, %User{} = user}), do: UserAgent.save(user)
  defp do_save({:error, _reason} = error), do: error
end
