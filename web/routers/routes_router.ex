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
