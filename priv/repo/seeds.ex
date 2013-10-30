defmodule Repo.Seeds do
  def run do
    Repo.delete_all(Route)
    Route.new(
      start:      "New York City, NY",
      finish:     "Portland,OR",
      waypoints:  "Chicago,IL",
      mode:       "bicycling")
      |> Repo.create
      |> Route.get_steps
  end
end
