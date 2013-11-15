defmodule GMaps.Steps do

  def get(route) do
    route
      |> get_directions
      |> parse_json
      |> Enum.map(&Step.from_json(&1))
      |> Enum.map(fn(step) -> step.route_id(route.id) end)
      |> Enum.map(&Repo.create(&1))
    route
  end

  def get_directions(route) do
    response = route
      |> get_params
      |> URI.encode_query
      |> GMaps.Directions.get([], [timeout: 30_000])
    response.body
  end

  def parse_json(json) do
    json
      |> HashDict.get("routes")
      |> Enum.first
      |> HashDict.get("legs")
      |> Enum.reduce [], fn (leg, steps) -> steps ++ HashDict.get(leg, "steps") end
  end

  def get_params(route) do
    [
      origin:      route.start,
      destination: route.finish,
      waypoints:   route |> Route.waypoints_list,
      mode:        route.mode,
      sensor:      false
    ]
  end

end
