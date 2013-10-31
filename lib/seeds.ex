defmodule Repo.Seeds do
  def run do
    reset_everything
    route = Route.new(
      name:       "Route",
      start:      "New York City, NY",
      finish:     "Portland,OR",
      waypoints:  "Chicago,IL",
      mode:       "bicycling")
      |> Repo.create
      |> GMaps.Steps.get

    route
      |> Route.steps_every_n_distance(50000)
      |> GMaps.Resources.get_nearby(["food"])
  end

  def reset_everything do
    [Route, Step, Resource] |> Enum.map(&Repo.delete_all(&1))
  end

end
