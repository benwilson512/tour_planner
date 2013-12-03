defmodule RoutesRouter do
  use Dynamo.Router

  get "/" do
    conn = conn.assign(:title, "Routes")
    render conn, "routes/index.html"
  end

  post "/" do
    steps = conn.params["route"]
      |> Binary.Dict.to_list
      |> Route.new
      |> Repo.create
      |> GMaps.Steps.get
    redirect conn, to: "/routes/"
  end

  get "/new" do
    conn = conn.assign(:resource_types, GMaps.Resources.types)
    render conn, "routes/new.html"
  end

  get "/:id" do
    route = route(conn.params[:id])
    conn  = conn.assign(:route, route)
    render conn, "routes/show.html"
  end

  delete "/:id" do
    conn.params[:id]
      |> route
      |> Repo.delete
  end

  defp route(id) do
    Repo.get(Route, id |> binary_to_integer)
  end
end
