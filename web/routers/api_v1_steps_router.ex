defmodule ApiV1StepsRouter do
  use Dynamo.Router

  get "/" do
    Step
      |> Repo.all
      |> Step.to_json
      |> conn.resp_body
  end

  get ":id" do
    conn.params[:id]
      |> step
      |> Step.to_json
      |> conn.resp_body
  end

  get ":id/resources" do
    step(conn.params[:id]).resources
      |> Resource.to_json
      |> conn.resp_body
  end

  defp step(id) do
    Repo.get(Step, id |> binary_to_integer)
  end

end
