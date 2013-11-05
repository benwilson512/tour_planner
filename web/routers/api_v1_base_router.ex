defmodule ApiV1BaseRouter do
  use Dynamo.Router

  prepare do
    conn = conn.resp_content_type("application/json")
  end

  forward "/routes", to: ApiV1RoutesRouter
  forward "/steps", to: ApiV1StepsRouter

end
