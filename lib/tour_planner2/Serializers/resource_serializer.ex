defmodule Resource.Serializer do
  use Base.Serializer

  def from_json(json) do
    rating = json["rating"]
    if rating != nil do
      rating = rating / 1.0
    end
    Resource.new(
      google_id:   json["id"],
      places_ref:  json["reference"],
      name:        json["name"],
      address:     json["vicinity"],
      lat:         json["geometry"]["location"]["lat"] / 1.0,
      lon:         json["geometry"]["location"]["lng"] / 1.0,
      price_level: json["price_level"],
      rating:      rating,
      types:       json["types"] |> Enum.join("|")
    )
  end
end
