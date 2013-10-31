defmodule RoutesRouter do
  use Dynamo.Router

  get "/.json" do
    conn = conn.resp_content_type("application/json")
    Route
      |> Repo.all
      |> Enum.map(&Route.attributes(&1))
      |> Enum.map(&json_safe(&1))
      |> Jsonex.encode
      |> conn.resp_body
  end

  get "/" do
    conn = conn.assign(:title, "yo")
    conn = conn.assign(:foo, "bar")
    render conn, "routes/index.html"
  end

  defp json_safe(attrs) do
    IO.inspect attrs
    attrs |> Enum.map(fn {key, value} ->
      if value do
        {key, value}
      else
        {key, ""}
      end
    end)
  end
end
