defmodule ReportsGenerator.FetchHigherCostTest do
  use ExUnit.Case

  alias ReportsGenerator.Build
  alias ReportsGenerator.FetchHigherCost

  describe "call/1" do
    test "returns the higher cost food" do
      filename = "report_test.csv"

      expected_response = {:ok, {"esfirra", 3}}

      {:ok, report} = Build.call(filename)

      response = FetchHigherCost.call(report, "foods")

      assert response == expected_response
    end

    test "returns the higher cost user" do
      filename = "report_test.csv"

      expected_response = {:ok, {"5", 49}}

      {:ok, report} = Build.call(filename)

      response = FetchHigherCost.call(report, "users")

      assert response == expected_response
    end

    test "returns an error if an invalid option is provided" do
      filename = "report_test.csv"

      expected_response = {:error, "An invalid option is provided"}

      response =
        Build.call(filename)
        |> FetchHigherCost.call("invalid_option")

      assert response == expected_response
    end
  end
end
