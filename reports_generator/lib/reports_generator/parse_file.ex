defmodule ReportsGenerator.ParseFile do
  @valid_reports ~w(report_1.csv report_2.csv report_3.csv report_complete.csv report_test.csv)

  def call(filename) when filename in @valid_reports do
    result =
      "reports/#{filename}"
      |> File.stream!()
      |> Stream.map(&parse_line/1)

    {:ok, result}
  end

  def call(_filename), do: {:error, "Report not found"}

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(2, &String.to_integer/1)
  end
end
