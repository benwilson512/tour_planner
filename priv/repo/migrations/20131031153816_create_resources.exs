defmodule Repo.Migrations.CreateResources do
  use Ecto.Migration

  def up do
    "CREATE TABLE resources (
      id            serial primary key,
      google_id     text,
      places_ref    text,
      name          text,
      address       text,
      lat           float,
      lon           float,
      price_level   integer,
      rating        float,
      types         text,
      updated_at    timestamp,
      created_at    timestamp DEFAULT LOCALTIMESTAMP
    );"
  end

  def down do
    "DROP TABLE resources;"
  end
end
