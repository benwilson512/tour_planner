defmodule Repo.Seeds do
  def run do
    reset_everything
    Route.new(
      start:      "New York City, NY",
      finish:     "Portland,OR",
      waypoints:  "Chicago,IL",
      mode:       "bicycling")
      |> Repo.create
      |> get_steps
  end

  def reset_everything do
    [Route, Step] |> Enum.map(&Repo.delete_all(&1))
  end

  def get_steps(route) do
    route
      |> get_directions
      |> parse_json
      |> Enum.map(&Step.create_from_json(&1, route))
      |> Enum.map(&Repo.create(&1))
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
