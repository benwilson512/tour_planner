defmodule Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def url do
    "ecto://tour_planner:tour_planner@localhost/tour_planner2_development"
  end

  def priv do
    "/Users/ben/projects/tour_planner2/priv/repo"
  end
end

defmodule Repo.Sup do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link({ :local, __MODULE__ }, __MODULE__, [])
  end

  def init([]) do
    tree = [ worker(Repo, []) ]
    supervise(tree, strategy: :one_for_all)
  end
end
