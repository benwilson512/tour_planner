defmodule StepsRouter do
  use Dynamo.Router

  get "/json" do
    Step
      |> Repo.all
      |> Enum.map(&Step.attributes(&1))
      |> Enum.map(&json_safe(&1))
      |> Jsonex.encode
      |> conn.resp_body
  end

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
