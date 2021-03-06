defmodule ApplicationRouter do
  use Dynamo.Router

  prepare do
    conn = conn.fetch([:cookies, :params])
    conn.assign :layout, "application"
  end

  forward "/steps", to: StepsRouter
  forward "/routes", to: RoutesRouter
  forward "/api/v1", to: ApiV1BaseRouter

  get "/" do
    conn = conn.assign(:title, "Welcome to Dynamo!")
    render conn, "index.html"
  end
end
