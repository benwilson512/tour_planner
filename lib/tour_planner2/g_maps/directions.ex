defmodule GMaps.Directions do
  use HTTPotion.Base

  def process_url(url) do
    "http://maps.googleapis.com/maps/api/directions/json?" <> url
  end

  def process_response_body(body) do
    {:ok, json} = body
      |> to_string
      |> JSON.decode
    json
  end

end
