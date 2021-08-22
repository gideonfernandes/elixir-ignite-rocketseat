defmodule Exlivery.Orders.GenerateReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.GenerateReport

  describe "call/1" do
    setup do
      Exlivery.start_agents()

      {:ok, user_cpf} = Exlivery.save_user(build(:user))

      items = [
        build(:item),
        build(:item, description: "Bolo de Cenoura", quantity: 2),
        build(:item, description: "Bolo de Laranja", quantity: 5)
      ]

      Exlivery.save_order(%{"items" => items, "user_cpf" => user_cpf})

      :ok
    end

    test "must generate a new report" do
      expected_response = "999.999.999-99, dessert, Bolo de Morango, 10, 25.50, dessert, Bolo de Cenoura, 2, 25.50, dessert, Bolo de Laranja, 5, 25.50, 433.50\n"

      GenerateReport.call("report.csv")

      response = File.read!("report.csv")

      assert response == expected_response
    end
  end
end
