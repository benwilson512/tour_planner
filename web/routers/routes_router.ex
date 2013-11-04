defmodule RoutesRouter do
  use Dynamo.Router

  get "/.json" do
    conn = conn.resp_content_type("application/json")
    IO.inspect conn.params[:format]
    Route
      |> Repo.all
      |> Route.to_json
      |> conn.resp_body
  end

  get "/" do
    conn = conn.assign(:title, "Routes")
    render conn, "routes/index.html"
  end

  get "/:id/.json" do
    conn = conn.resp_content_type("application/json")
    conn.params[:id]
      |> route
      |> Route.to_json
      |> conn.resp_body
  end

  get "/:id" do
    conn = conn.assign(:route, route(conn.params[:id]))
    render conn, "routes/show.html"
  end

  get "/:id/steps/.json" do
    conn = conn.resp_content_type("application/json")
    route = conn.params[:id] |> route
    if conn.params[:important] do
      steps = route |> Route.important_steps
    else
      steps = route.steps |> Repo.all
    end
    steps
      |> Step.to_json
      |> conn.resp_body
  end

  defp route(id) do
    Repo.get(Route, id |> binary_to_integer)
  end
end
