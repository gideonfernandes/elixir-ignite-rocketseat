defmodule ReportsGenerator.BuildTest do
  use ExUnit.Case

  alias ReportsGenerator.Build

  describe "call/1" do
    test "returns the report" do
      filename = "report_test.csv"

      expected_response =
        {:ok,
         %{
           "foods" => %{
             "açaí" => 1,
             "churrasco" => 2,
             "esfirra" => 3,
             "hambúrguer" => 2,
             "pastel" => 0,
             "pizza" => 2,
             "prato_feito" => 0,
             "sushi" => 0
           },
           "users" => %{
             "1" => 48,
             "10" => 36,
             "11" => 0,
             "12" => 0,
             "13" => 0,
             "14" => 0,
             "15" => 0,
             "16" => 0,
             "17" => 0,
             "18" => 0,
             "19" => 0,
             "2" => 45,
             "20" => 0,
             "21" => 0,
             "22" => 0,
             "23" => 0,
             "24" => 0,
             "25" => 0,
             "26" => 0,
             "27" => 0,
             "28" => 0,
             "29" => 0,
             "3" => 31,
             "30" => 0,
             "4" => 42,
             "5" => 49,
             "6" => 18,
             "7" => 27,
             "8" => 25,
             "9" => 24
           }
         }}

      response = Build.call(filename)

      assert response == expected_response
    end

    test "returns and error if the report name is invalid" do
      filename = "invalid_report.csv"

      expected_response = {:error, "Report not found"}

      response = Build.call(filename)

      assert response == expected_response
    end
  end
end
