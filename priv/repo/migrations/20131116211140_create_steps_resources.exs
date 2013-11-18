defmodule Repo.Migrations.CreateStepsResources do
  use Ecto.Migration

  def up do
    "CREATE TABLE resources_steps (
      id            serial,
      resource_id   integer REFERENCES resources(id),
      step_id       integer REFERENCES steps(id),
      PRIMARY KEY(resource_id, step_id)
    );"
  end

  def down do
    "DROP TABLE resources_steps;"
  end
end
