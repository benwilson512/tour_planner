defmodule GMaps.Places do
  use HTTPotion.Base

  def process_url(url) do
    "https://maps.googleapis.com/maps/api/place/nearbysearch/json?" <> url
  end

  def process_response_body(body) do
    {:ok, json} = body
      |> to_string
      |> JSON.decode
    json
  end

end
