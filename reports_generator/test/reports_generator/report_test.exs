defmodule ReportsGenerator.ReportTest do
  use ExUnit.Case

  alias ReportsGenerator.Report

  describe "build/2" do
    test "returns an report structure" do
      users = []
      foods = []

      expected_response = %{"foods" => [], "users" => []}

      response = Report.build(users, foods)

      assert response == expected_response
    end
  end
end
