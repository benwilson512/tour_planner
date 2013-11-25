defmodule Mix.Tasks.Database do

  defmodule Reset do
    use Mix.Task
    def run(_) do
      Mix.shell.cmd("dropdb --if-exists -e #{Repo.config["database"]}")
      Mix.shell.cmd("createdb -e #{Repo.config["database"]}")
      Mix.Task.run "ecto.migrate", [Repo]
    end
  end

  defmodule Seed do
    use Mix.Task
    def run(_) do
      Mix.Task.run "database.reset"
      Repo.Seeds.run
    end
  end
end
