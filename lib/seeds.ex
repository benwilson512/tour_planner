defmodule Repo.Seeds do
  def run do
    route = Route.new(
      name:       "Route",
      start:      "New York City, NY",
      finish:     "Portland,OR",
      waypoints:  "Chicago,IL",
      mode:       "bicycling")
      |> Repo.create
      |> GMaps.Steps.get

    steps = route
      |> Route.important_steps(50000)

    IO.puts "This will generate #{Enum.count(steps) * Enum.count(resource_types)} places queries"
    resource_types
      |> Enum.map(&GMaps.Resources.get_nearby(steps, &1))
    route
  end

  def resource_types do
    "atm
    bar
    bicycle_store
    cafe
    campground
    church
    clothing_store
    convenience_store
    department_store
    doctor
    food
    gas_station
    grocery_or_supermarket
    gym
    hair_care
    hardware_store
    hospital
    laundry
    library
    liquor_store
    lodging
    mosque
    movie_theater
    museum
    night_club
    park
    pharmacy
    place_of_worship
    police
    post_office
    restaurant
    rv_park
    store
    subway_station
    taxi_stand
    train_station"
      |> String.split("\n")
      |> Enum.map(&([String.strip(&1)]))
  end

end
