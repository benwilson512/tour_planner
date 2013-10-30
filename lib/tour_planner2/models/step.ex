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
  end

  def create_from_json(json) do
    Step.new(
      start_lat:    json["start_location"]["lat"],
      start_lon:    json["start_location"]["lng"],
      end_lat:      json["end_location"]["lat"],
      end_lon:      json["end_location"]["lng"],
      instructions: json["html_instructions"],
      distance:     json["distance"]["value"]
    )
  end
  def create_from_json(json, route) do
    step = create_from_json(json)
    if route.id do
      route.id |> step.route_id
    end
  end
end
