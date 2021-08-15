defmodule ReportsGenerator.ParallelBuildTest do
  use ExUnit.Case

  alias ReportsGenerator.ParallelBuild

  describe "call/1" do
    test "returns the report" do
      filenames = ["report_5.csv", "report_2.csv", "report_3.csv"]

      expected_response = {
        :ok,
        %{
          "foods" => %{
            "açaí" => 25199,
            "churrasco" => 25065,
            "esfirra" => 24994,
            "hambúrguer" => 24984,
            "pastel" => 24943,
            "pizza" => 24939,
            "prato_feito" => 25033,
            "sushi" => 24843
          },
          "users" => %{
            "1" => 184_734,
            "10" => 179_566,
            "11" => 179_086,
            "12" => 183_495,
            "13" => 190_051,
            "14" => 186_921,
            "15" => 184_909,
            "16" => 180_731,
            "17" => 179_314,
            "18" => 179_730,
            "19" => 186_806,
            "2" => 178_558,
            "20" => 183_143,
            "21" => 184_675,
            "22" => 183_632,
            "23" => 181_817,
            "24" => 183_560,
            "25" => 183_543,
            "26" => 185_199,
            "27" => 187_512,
            "28" => 180_682,
            "29" => 184_583,
            "3" => 181_557,
            "30" => 184_240,
            "4" => 185_660,
            "5" => 179_679,
            "6" => 181_366,
            "7" => 180_086,
            "8" => 182_233,
            "9" => 182_233
          }
        }
      }

      response = ParallelBuild.call(filenames)

      assert response == expected_response
    end

    test "returns and error if an invalid filenames list is provided" do
      filenames = "invalid_reports.csv"

      expected_response = {:error, "An invalid filenames list was provided"}

      response = ParallelBuild.call(filenames)

      assert response == expected_response
    end
  end
end
