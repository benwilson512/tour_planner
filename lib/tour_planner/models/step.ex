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
    field :important,     :boolean
    field :created_at,    :datetime
    field :updated_at,    :datetime

    def resources(step) do
      Repo.all(
        from    s  in Step,
        join:   rs in ResourceStep, on: rs.step_id == s.id,
        join:   r  in Resource,     on: r.id == rs.resource_id,
        where:  s.id == ^step.id,
        order:  r.id
        select: r
      )
    end

    def near_resources(step, radius // 16_000) do
      Repo.all(
        from r in Resource,
        where: r.lat < (^step.start_lat + ^radius) and r.lat > (^step.start_lat + ^radius)
          and r.lon < (^step.start_lon + ^radius) and r.lon > (^step.start_lon + ^radius)
      )
    end
  end
end
