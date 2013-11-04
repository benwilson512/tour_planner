defmodule StepsRouter do
  use Dynamo.Router

  get "/json" do
    Step
      |> Repo.all
      |> Step.to_json
      |> conn.resp_body
  end
end
