defmodule TourPlanner.Model do
  defmacro __using__(_) do
    quote do
      use Ecto.Model
      import Ecto.Query
      use Model.Attributes
      use Model.Serialize
      use Model.Queryable
    end
  end
end
