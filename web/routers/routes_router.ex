defmodule RoutesRouter do
  use Dynamo.Router

  get "/json" do
    conn = conn.resp_content_type("application/json")
    Route
      |> Repo.all
      |> Route.to_json
      |> conn.resp_body
  end

  get "/" do
    conn = conn.assign(:title, "Routes")
    render conn, "routes/index.html"
  end

  get "/:id" do
    route = Repo.get(Route, conn.params(:id))
    conn = conn.assign(:route, route)
    render conn, "routes/show.html"
  end

  get "/:id/json" do
    Route
      |> Repo.get(conn.params(:id))
      |> Route.to_json
      |> conn.resp_body
  end

  get "/:id/steps/important/json" do

  end
end
