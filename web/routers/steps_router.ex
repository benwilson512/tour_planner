defmodule StepsRouter do
  use Dynamo.Router

  get "/json" do
    Step
      |> Repo.all
      |> Enum.map(&Step.attributes(&1))
      |> Jsonex.encode
      |> conn.resp_body
  end
end
