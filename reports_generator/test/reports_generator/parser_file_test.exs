defmodule ReportsGenerator.ParseFileTest do
  use ExUnit.Case

  alias ReportsGenerator.ParseFile

  describe "call/1" do
    test "returns an stream if report name is valid" do
      filename = "report_test.csv"

      response = ParseFile.call(filename)

      assert {:ok, _stream_content} = response
    end

    test "returns an error if report name is invalid" do
      filename = "invalid_report.csv"

      expected_response = {:error, "Report not found"}

      response = ParseFile.call(filename)

      assert response == expected_response
    end

    test "returns the parsed file" do
      filename = "report_test.csv"

      expected_response = [
        ["1", "pizza", 48],
        ["2", "açaí", 45],
        ["3", "hambúrguer", 31],
        ["4", "esfirra", 42],
        ["5", "hambúrguer", 49],
        ["6", "esfirra", 18],
        ["7", "pizza", 27],
        ["8", "esfirra", 25],
        ["9", "churrasco", 24],
        ["10", "churrasco", 36]
      ]

      {:ok, stream_content} = ParseFile.call(filename)

      response =
        stream_content
        |> Enum.map(& &1)

      assert response == expected_response
    end
  end
end
