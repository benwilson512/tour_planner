defmodule Repo.Seeds do
  def run do
    reset_everything
    Route.new(
      name:       "Route",
      start:      "New York City, NY",
      finish:     "Portland,OR",
      waypoints:  "Chicago,IL",
      mode:       "bicycling")
      |> Repo.create
      |> GMaps.Steps.get
  end

  def reset_everything do
    [Route, Step] |> Enum.map(&Repo.delete_all(&1))
  end

end
