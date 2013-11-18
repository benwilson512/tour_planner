defmodule ResourceStep do
  use TourPlanner.Model

  queryable "resources_steps" do
    belongs_to :resource, Resource
    belongs_to :step,     Step
  end

end
