defmodule RoutesRouter do
  use Dynamo.Router

  get "/" do
    conn = conn.assign(:title, "Routes")
    render conn, "routes/index.html"
  end

  get "/:id" do
    conn = conn.assign(:route, route(conn.params[:id]))
    render conn, "routes/show.html"
  end

  defp route(id) do
    Repo.get(Route, id |> binary_to_integer)
  end
end
