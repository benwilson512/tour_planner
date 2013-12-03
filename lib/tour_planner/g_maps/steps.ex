defmodule GMaps.Steps do
  import HashDict
  import Enum

  def get(route) do
    route
      |> get_directions
      |> parse_json
      |> map(&Step.from_json(&1))
      |> map(fn(step) -> step.route_id(route.id) end)
      |> map(&Repo.create(&1))
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
      |> get("routes")
      |> first
      |> get("legs")
      |> Enum.reduce [], fn (leg, steps) -> steps ++ get(leg, "steps") end
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
