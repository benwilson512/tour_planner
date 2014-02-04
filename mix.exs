defmodule TourPlanner.Mixfile do
  use Mix.Project

  def project do
    [ app: :tour_planner,
      version: "0.0.1",
      dynamos: [TourPlanner.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      env: [prod: [compile_path: "ebin"]],
      compile_path: "tmp/#{Mix.env}/tour_planner/ebin",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo, :httpotion],
      mod: { TourPlanner, [] } ]
  end

  defp deps do
    [
      { :exactor, github: "sasa1977/exactor" },
      { :cowboy, github: "extend/cowboy" },
      { :dynamo, github: "elixir-lang/dynamo", branch: "master" },
      { :postgrex, github: "ericmj/postgrex", override: true},
      { :ecto, github: "elixir-lang/ecto", branch: "master" },
      { :httpotion, github: "myfreeweb/httpotion", branch: "master"},
      { :json,   github: "cblage/elixir-json"}
    ]
  end
end
