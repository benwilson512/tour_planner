defmodule GMaps.Resources do
  def get_nearby(locations, types, radius // 16_000) do
    locations
      |> Stream.map(&get_resources(&1, types, radius))
      |> Enum.to_list
    locations
  end

  def get_resources(location, types, radius) do
    IO.write "."
    location
      |> get_params(types, radius)
      |> URI.encode_query
      |> GMaps.Places.get([], [timeout: 30_000])
      |> get_body
      |> HashDict.get("results")
      |> Enum.map(&Resource.from_json(&1))
      |> Enum.map(&create_or_link(&1, location))
  end

  def create_or_link(resource, location) do
    dup = Enum.first(resource.find_dups)
    resource = if dup do dup else resource |> Repo.create end
    ResourceStep.new(resource_id: resource.id, step_id: location.id)
      |> Repo.create
  end

  def get_body(response) do
    response.body
  end

  def get_params(location, types, radius) do
    [
      key:      GMaps.api_key,
      location: "#{location.start_lat},#{location.start_lon}",
      types:    types |> Enum.join("|"),
      radius:   radius,
      sensor:   false
    ]
  end

  def types do
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
