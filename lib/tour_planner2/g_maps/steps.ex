defmodule GMaps.Steps do

  def get(route) do
    route
      |> get_directions
      |> parse_json
      |> Enum.map(&Step.from_json(&1, route))
      |> Enum.map(&Repo.create(&1))
    route
  end

  def get_directions(route) do
    response = route
      |> get_params
      |> URI.encode_query
      |> GMaps.Directions.get([], [timeout: 30000])  
    response.body
  end

  def parse_json(json) do
    json
      |> ListDict.get("routes")
      |> Enum.first
      |> ListDict.get("legs")
      |> Enum.reduce [], fn (leg, steps) -> steps ++ ListDict.get(leg, "steps") end
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
