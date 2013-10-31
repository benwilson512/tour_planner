defmodule RoutesRouter do
  use Dynamo.Router

  get "/json" do
    Route
      |> Repo.all
      |> Enum.map(&Route.attributes(&1))
      |> Jsonex.encode
      |> conn.resp_body
  end
end
