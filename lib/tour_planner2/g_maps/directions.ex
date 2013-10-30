defmodule GMaps.Directions do
  use HTTPotion.Base

  def process_url(url) do
    "http://maps.googleapis.com/maps/api/directions/json?" <> url
  end

  def process_response_body(body) do
    body
      |> to_string
      |> Jsonex.decode
  end

end
