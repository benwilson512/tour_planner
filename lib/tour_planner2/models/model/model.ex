defmodule TourPlanner.Model do
  defmacro __using__(_) do
    quote do
      use Ecto.Model
      use Model.Attributes
      use Model.Serialize

      def all   do Repo.all(__MODULE__)   end
      def first do Repo.first(__MODULE__) end
      def last  do Repo.last(__MODULE__)  end
    end
  end
end