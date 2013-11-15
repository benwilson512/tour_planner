defmodule Step.Serializer do
  use Base.Serializer

  def from_json(json) do
    Step.new(
      start_lat:    json["start_location"]["lat"],
      start_lon:    json["start_location"]["lng"],
      end_lat:      json["end_location"]["lat"],
      end_lon:      json["end_location"]["lng"],
      instructions: json["html_instructions"] |> String.replace(%r/<[^>]*>/, ""),
      distance:     json["distance"]["value"]
    )
  end

end
