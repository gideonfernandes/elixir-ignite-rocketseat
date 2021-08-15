defmodule ReportsGenerator.FetchHigherCost do
  @higher_cost_options ~w(foods users)

  def call(report, option) when option in @higher_cost_options do
    {:ok, Enum.max_by(report[option], fn {_key, value} -> value end)}
  end

  def call(_report, _option), do: {:error, "An invalid option is provided"}
end
