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
      created_at    timestamp,
      updated_at    timestamp
    );"
  end

  def down do
    "DROP TABLE resources;"
  end
end
