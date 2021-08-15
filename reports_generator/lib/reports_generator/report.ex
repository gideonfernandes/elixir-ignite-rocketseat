defmodule ReportsGenerator.Report do
  def build(users, foods), do: %{"users" => users, "foods" => foods}
end
