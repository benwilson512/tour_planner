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
      |> Route.important_steps(50000)
      |> GMaps.Resources.get_nearby(["food"])
  end

  def reset_everything do
    [ResourceStep, Route, Step, Resource] |> Enum.map(&Repo.delete_all(&1))
  end

end
