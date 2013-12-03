defmodule Mix.Tasks.Db do

  defmodule Nuke do
    use Mix.Task
    def run(_) do
      Mix.shell.cmd("dropdb -U #{Repo.config["user"]} -e #{Repo.config["database"]}")
      Mix.shell.cmd("dropuser #{Repo.config["user"]}")
    end
  end

  defmodule Setup do
    use Mix.Task
    def run(_) do
      Mix.shell.cmd("createuser #{Repo.config["user"]} -d")
      Mix.shell.cmd("createdb -U #{Repo.config["user"]} -e #{Repo.config["database"]}")
      Mix.Task.run "ecto.migrate", [Repo]
    end
  end

  defmodule Reset do
    use Mix.Task
    def run(_) do
      Mix.shell.cmd("dropdb -U #{Repo.config["user"]} -e #{Repo.config["database"]}")
      Mix.shell.cmd("createdb -U #{Repo.config["user"]} -e #{Repo.config["database"]}")
      Mix.Task.run "ecto.migrate", [Repo]
    end
  end

  defmodule Seed do
    use Mix.Task
    def run(_) do
      Mix.Task.run "db.reset"
      TourPlanner.start
      Repo.Seeds.run
    end
  end
end
