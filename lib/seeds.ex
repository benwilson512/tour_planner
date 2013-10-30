defmodule Repo.Seeds do
  def run do
    Route.new(
      start:      "New York City, NY",
      finish:     "Portland,OR",
      waypoints:  "Chicago,IL",
      mode:       "bicycling")
      |> Repo.create
      |> Route.get_steps
  end
end
