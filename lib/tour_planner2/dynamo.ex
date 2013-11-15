defmodule TourPlanner2.Dynamo do
  use Dynamo

  config :dynamo,
    # The environment this Dynamo runs on
    env: Mix.env,

    # The OTP application associated with this Dynamo
    otp_app: :tour_planner2,

    # The endpoint to dispatch requests to
    endpoint: ApplicationRouter,

    # The route from which static assets are served
    # You can turn off static assets by setting it to false
    static_route: "/static"

  # Uncomment the lines below to enable the cookie session store
  # config :dynamo,
  #   session_store: Session.CookieStore,
  #   session_options:
  #     [ key: "_tour_planner2_session",
  #       secret: "qSgClBd433R3c0ACTIjmuNRzl7GH41jsn468Fcg0SeKbqsS+tX3aLZVgIC69CBxE"]

  # Default functionality available in templates
  templates do
    use Dynamo.Helpers
    import ApplicationHelper
  end
end
