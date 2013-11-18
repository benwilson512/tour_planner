defmodule Step do
  use TourPlanner.Model

  queryable "steps" do
    belongs_to :route, Route

    field :start_lat,     :float
    field :start_lon,     :float
    field :end_lat,       :float
    field :end_lon,       :float
    field :distance,      :integer
    field :instructions,  :string
    field :created_at,    :datetime
    field :updated_at,    :datetime

    def resources(step) do
      Repo.all(
        from    s  in Step,
        join:   rs in ResourceStep, on: rs.step_id == s.id,
        join:   r  in Resource,     on: r.id == rs.resource_id,
        where:  s.id == ^step.id,
        select: r
      )
    end
  end
end
