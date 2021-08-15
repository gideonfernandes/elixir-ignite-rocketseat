defmodule ReportsGenerator do
  alias ReportsGenerator.Build
  alias ReportsGenerator.ParallelBuild
  alias ReportsGenerator.FetchHigherCost

  defdelegate build(filename), to: Build, as: :call
  defdelegate parallel_build(filenames), to: ParallelBuild, as: :call
  defdelegate fetch_higher_cost(report, option), to: FetchHigherCost, as: :call
end
