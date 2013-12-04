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
    {:ok, types} = GMaps.Resources.types
      |> Enum.map(&(format_types(&1)))
      |> JSON.encode
    conn  = conn.assign(:route, route).
                 assign(:steps, route.important_steps |> Repo.all).
                 assign(:types, types)
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

  defp format_types(string) do
    title = string
      |> String.split("_")
      |> Enum.map(&(String.capitalize(&1)))
      |> Enum.join(" ")
    [title: title, stub: string]
  end
end
