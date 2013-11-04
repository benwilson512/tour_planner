defmodule GMaps.Resources do
  def get_nearby(locations, types, radius // 16_000) do
    IO.puts "Retrieving resources near #{Enum.count(locations)} locations"
    locations
      |> Stream.map(&get_resources(&1, types, radius))
      |> Enum.to_list
  end

  def get_resources(location, types, radius) do
    IO.write "."
    location
      |> get_params(types, radius)
      |> URI.encode_query
      |> GMaps.Places.get
      |> get_body
      |> ListDict.get("results")
      |> Enum.map(&Resource.from_json(&1))
      |> Enum.map(&Repo.create(&1))
  end

  def get_body(response) do
    response.body
  end

  def get_params(location, types, radius) do
    [
      key:      "AIzaSyAb2SNcoUwumA8tKyOd6dFInnuelCDUvYM",
      location: "#{location.start_lat},#{location.start_lon}",
      types:    types |> Enum.join("|"),
      radius:   radius,
      sensor:   false
    ]
  end

end
