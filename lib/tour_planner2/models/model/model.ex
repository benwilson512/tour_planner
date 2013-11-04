defmodule TourPlanner.Model do
  defmacro __using__(_) do
    quote do
     use Model.Attributes
     use Model.Serialize
    end
  end
end