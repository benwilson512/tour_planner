defmodule Step do
  use Ecto.Model

  queryable "steps" do
    belongs_to :route, Route

    field :start_lat,     :float
    field :start_lon,     :float
    field :end_lat,       :float
    field :end_lon,       :float
    field :distance,      :integer
    field :instructions,  :string
    field :created_at,    :datetime
    field :updated_at,    :datetime
  end

  # This should totally be dynamic but I'm lazy
  # right now. Frankly Ecto should make this easy
  # FIXME
  def attributes(route) do
    fields |> Enum.map(&{&1, apply(__MODULE__.Entity, &1, [route])})
  end
  def fields do
    __MODULE__.Entity.__entity__(:field_names)
  end

  def from_json(json) do
    Step.new(
      start_lat:    json["start_location"]["lat"],
      start_lon:    json["start_location"]["lng"],
      end_lat:      json["end_location"]["lat"],
      end_lon:      json["end_location"]["lng"],
      instructions: json["html_instructions"],
      distance:     json["distance"]["value"]
    )
  end
  def from_json(json, route) do
    step = from_json(json)
    if route.id do
      route.id |> step.route_id
    end
  end
end
