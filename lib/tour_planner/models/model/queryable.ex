defmodule Model.Queryable do
  defmacro __using__(_opts) do
    quote do
      import Model.Queryable

      def all do
        Repo.all(default_query)
      end

      def where(clause) do
        query("select * from #{__MODULE__.__model__(:source)} WHERE #{clause}")
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

      def query(sql) do
        Repo.query __MODULE__.Entity, sql
      end
    end
  end
end
