defmodule Repo.Migrations.CreateSteps do
  use Ecto.Migration

  def up do
    "CREATE TABLE steps (
      id            serial primary key,
      route_id      integer,
      distance      integer,
      instructions  text,
      start_lat     float,
      start_lon     float,
      end_lat       float,
      end_lon       float,
      updated_at    timestamp,
      created_at    timestamp DEFAULT LOCALTIMESTAMP
    );"
  end

  def down do
    "DROP TABLE steps;"
  end
end
