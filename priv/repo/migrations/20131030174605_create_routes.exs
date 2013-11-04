defmodule Repo.Migrations.CreateRoutes do
  use Ecto.Migration

  def up do
    "CREATE TABLE routes (
      id        serial primary key,
      name      text,
      start     text,
      finish    text,
      mode      text,
      waypoints text,
      distance  text,
      updated_at timestamp,
      created_at timestamp DEFAULT LOCALTIMESTAMP
    );"
  end

  def down do
    "DROP TABLE routes;"
  end
end
