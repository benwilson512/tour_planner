defmodule ApiV1RoutesRouter do
  use Dynamo.Router

  get "/" do
    Route.all
      |> Route.to_json
      |> conn.resp_body
  end

  get "/:id" do
    conn.params[:id]
      |> route
      |> Route.to_json
      |> conn.resp_body
  end

  get "/:id/steps" do
    route = conn.params[:id] |> route
    if conn.params[:important] do
      steps = route |> Route.important_steps
    else
      steps = route |> Route.steps |> Repo.all
    end
    steps
      |> Step.to_json
      |> conn.resp_body
  end

  defp route(id) do
    Repo.get(Route, id |> binary_to_integer)
  end

end
