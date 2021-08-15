defmodule ReportsGenerator.Build do
  alias ReportsGenerator.Report
  alias ReportsGenerator.ParseFile

  @available_foods ~w(açaí churrasco esfirra hambúrguer pastel pizza prato_feito sushi)

  def call(filename) do
    with {:ok, stream_content} <- ParseFile.call(filename) do
      result =
        stream_content
        |> Enum.reduce(report_acc(), fn line, report -> sum_prices(line, report) end)

      {:ok, result}
    end
  end

  defp sum_prices([id, food_name, price], %{"foods" => foods, "users" => users}) do
    users = Map.put(users, id, users[id] + price)
    foods = Map.put(foods, food_name, foods[food_name] + 1)

    Report.build(users, foods)
  end

  defp report_acc do
    foods = Enum.into(@available_foods, %{}, &{&1, 0})
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

    Report.build(users, foods)
  end
end
