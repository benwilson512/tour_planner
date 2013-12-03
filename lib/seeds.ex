defmodule Repo.Seeds do
  def run do
    route = Route.new(
      name:       "Route",
      start:      "New York City, NY",
      finish:     "Seatle,WA",
      waypoints:  "Chicago,IL",
      mode:       "bicycling")
      |> Repo.create
      |> GMaps.Steps.get

    steps = route
      |> Route.important_steps
      |> Repo.all

    IO.puts "This will generate #{Enum.count(steps) * Enum.count(GMaps.Resources.types)} places queries"
    GMaps.Resources.types
      |> Enum.map(&([&1]))
      |> Enum.map(&GMaps.Resources.get_nearby(steps, &1))
    route
  end

end
