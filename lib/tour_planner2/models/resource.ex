defmodule Resource do
  use Ecto.Model

  queryable "resources" do
    field :google_id,   :string
    field :places_ref,  :string
    field :name,        :string
    field :address,     :string
    field :lat,         :float
    field :lon,         :float
    field :price_level, :integer
    field :rating,      :float
    field :types,       :string
    field :created_at,  :datetime
    field :updated_at,  :datetime
  end

  # This should totally be dynamic but I'm lazy
  # right now. Frankly Ecto should make this easy
  # FIXME
  def attributes(record) do
    [
    ]
  end

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
