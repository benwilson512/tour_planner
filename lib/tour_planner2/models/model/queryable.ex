defmodule Model.Queryable do

  defmacro __using__(_opts) do
    quote do

      def all do
        Repo.all(default_query)
      end

      def first do
        [result] = Repo.all(from m in __MODULE__, order_by: [asc: m.id], limit: 1)
        result
      end

      def last do
        [result] = Repo.all(from m in __MODULE__, order_by: [desc: m.id], limit: 1)
        result
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
