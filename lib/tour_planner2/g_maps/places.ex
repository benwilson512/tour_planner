defmodule GMaps.Places do
  use HTTPotion.Base

  def process_url(url) do
    "https://maps.googleapis.com/maps/api/place/nearbysearch/json?" <> url
  end

  def process_response_body(body) do
    body
      |> to_string
      |> Jsonex.decode
  end

end
