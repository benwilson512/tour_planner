defmodule RoutesRouter do
  use Dynamo.Router

  get "/routes.json" do
    conn = conn.resp_content_type("application/json")
    Route
      |> Repo.all
      |> Enum.map(&Route.attributes(&1))
      |> Enum.map(&json_safe(&1))
      |> Jsonex.encode
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
      |> Route.attributes
      |> json_safe
      |> Jsonex.encode
      |> conn.resp_body
  end

  get "/:id/steps/important/json" do

  end

  # Jsonex can't handle nil values. yay.
  # This will get moved somewhere better
  # later. FIXME
  defp json_safe(attrs) do
    attrs |> Enum.map(fn {key, value} ->
      if value do
        {key, value}
      else
        {key, ""}
      end
    end)
  end
end
