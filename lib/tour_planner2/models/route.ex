defmodule Route do
  use TourPlanner.Model

  queryable "routes" do
    has_many :steps, Step

    field :name,      :string
    field :start,     :string
    field :finish,    :string
    field :mode,      :string
    field :waypoints, :string
    field :distance,  :string
    # field :updated_at, :datetime
    # field :created_at, :datetime
  end

  def important_steps(route, max_dist // 50_000) do
    route
      |> Route.steps
      |> Repo.all
      |> filter_steps(max_dist, [], 0)
      |> Enum.reverse
  end

  defp filter_steps([], _max_dist, keep, _), do: keep

  defp filter_steps([step | steps], max_dist, keep, dist_traveled) do
    if step.distance >= max_dist || dist_traveled > max_dist do
      filter_steps(steps, max_dist, [step | keep], 0)
    else
      filter_steps(steps, max_dist, keep, step.distance + dist_traveled)
    end
  end

  def waypoints_list(route) do
    String.split(route.waypoints, "|")
  end

  def steps(route) do
    from s in route.steps, order_by: [asc: s.id]
  end
end
