defmodule TourPlanner.Model do
  defmacro __using__(_) do
    quote do
      use Ecto.Model
      import Ecto.Query
      use Model.Attributes
      use Model.Serialize


      def all do
        Repo.all(default_query)
      end
      def first do
        Repo.all(from m in __MODULE__, order_by: [asc: m.id], limit: 1)
          |> Enum.first
      end
      def last do
        Repo.all(from m in __MODULE__, order_by: [desc: m.id], limit: 1)
          |> Enum.first
      end

      def count do
        [result] = Repo.all(from __MODULE__ |>  select([m], count(m.id)))
        result
      end

      def default_query do
        from m in __MODULE__, order_by: [asc: m.id]
      end
    end
  end
end
