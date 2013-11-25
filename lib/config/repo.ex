defmodule Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def config do
    {:ok, file}   = File.read("lib/config/database.json")
    {:ok, config} =  file |> JSON.decode
    config[atom_to_binary(Mix.env)]
  end

  def url do
    c = config
    "ecto://#{c["user"]}:#{c["password"]}@localhost/#{c["database"]}"
  end

  def priv do
    "priv/repo"
  end

  def query(sql) do
    __MODULE__.adapter.query(__MODULE__, sql)
  end

  def query(entity, sql) do
    Postgrex.Result[columns: columns, rows: rows] = query(sql)
    Enum.map(rows, fn(row) ->
      columns
        |> Enum.zip(tuple_to_list(row))
        |> entity.new
      end)
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
