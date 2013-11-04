defmodule TourPlanner2.Mixfile do
  use Mix.Project

  def project do
    [ app: :tour_planner2,
      version: "0.0.1",
      dynamos: [TourPlanner2.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      env: [prod: [compile_path: "ebin"]],
      compile_path: "tmp/#{Mix.env}/tour_planner2/ebin",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo, :httpotion],
      mod: { TourPlanner2, [] } ]
  end

  defp deps do
    [ { :cowboy, github: "extend/cowboy" },
      { :dynamo, "0.1.0-dev", github: "elixir-lang/dynamo" },
      { :postgrex, github: "ericmj/postgrex", branch: "master" },
      { :ecto, github: "elixir-lang/ecto", branch: "master" },
      { :httpotion, github: "benwilson512/httpotion", branch: "master"},
      { :jsonex, github: "marcelog/jsonex" }
    ]
  end
end
