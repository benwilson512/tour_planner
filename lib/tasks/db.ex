defmodule Mix.Tasks.Db do

  defmodule Reset do
    use Mix.Task
    def run(_) do
      Mix.shell.cmd("dropdb -e #{Repo.config["database"]}")
      Mix.shell.cmd("createdb -e #{Repo.config["database"]}")
      Mix.Task.run "ecto.migrate", [Repo]
    end
  end

  defmodule Seed do
    use Mix.Task
    def run(_) do
      Mix.Task.run "db.reset"
      Repo.Seeds.run
    end
  end
end
