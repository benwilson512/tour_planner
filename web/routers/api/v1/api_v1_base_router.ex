defmodule Api.V1.BaseRouter do
  use Dynamo.Router

  prepare do
    conn = conn.resp_content_type("application/json")
  end

  forward "/routes", to: Api.V1.RoutesRouter
  forward "/steps", to: Api.V1.StepsRouter

end
