defmodule TourPlanner.Entity do
  defmacro __using__(_) do
    quote do
      use Ecto.Entity
      import Ecto.Query
    end
  end
end