defmodule ReportsGenerator.ParallelBuild do
  alias ReportsGenerator.Build
  alias ReportsGenerator.Report

  @available_foods ~w(açaí churrasco esfirra hambúrguer pastel pizza prato_feito sushi)

  def call(filenames) when is_list(filenames) do
    result =
      filenames
      |> Task.async_stream(&Build.call/1)
      |> Enum.reduce(report_acc(), &handle_reports_sum/2)

    {:ok, result}
  end

  def call(_filenames), do: {:error, "An invalid filenames list was provided"}

  defp report_acc do
    foods = Enum.into(@available_foods, %{}, &{&1, 0})
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

    Report.build(users, foods)
  end

  defp handle_reports_sum({:ok, {:ok, content}}, report), do: sum_reports(report, content)
  defp handle_reports_sum({:ok, {:error, _reason}}, report), do: report

  defp sum_reports(report, next_report) do
    foods = Map.merge(report["foods"], next_report["foods"], &sum_map_values/3)
    users = Map.merge(report["users"], next_report["users"], &sum_map_values/3)

    Report.build(users, foods)
  end

  defp sum_map_values(_key, map_value1, map_value2), do: map_value1 + map_value2
end
