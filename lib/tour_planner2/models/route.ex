defmodule Route do
  use Ecto.Model

  queryable "routes" do
    has_many :steps, Step

    field :name,      :string
    field :start,     :string
    field :finish,    :string
    field :mode,      :string
    field :waypoints, :string
    field :distance,  :string
  end

  # This should totally be dynamic but I'm lazy
  # right now. Frankly Ecto should make this easy
  # FIXME
  def attributes(route) do
    fields |> Enum.map(&{&1, apply(__MODULE__.Entity, &1, [route])})
  end
  def fields do
    __MODULE__.Entity.__entity__(:field_names)
  end

  def steps_every_n_distance(route, max_dist // 50_000) do
    route.steps
      |> Repo.all
      |> filter_steps(max_dist, [], 0)
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
end
