defmodule Step.Serializer do
  use Base.Serializer

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
