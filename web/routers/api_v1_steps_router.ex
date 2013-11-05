defmodule ApiV1StepsRouter do
  use Dynamo.Router

  get "/" do
    Step
      |> Repo.all
      |> Step.to_json
      |> conn.resp_body
  end

end
