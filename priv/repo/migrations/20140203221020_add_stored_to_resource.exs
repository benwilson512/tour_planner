defmodule Repo.Migrations.AddStoredToResource do
  use Ecto.Migration

  def up do
    "ALTER TABLE resources ADD COLUMN on_device boolean;"
  end

  def down do
    ""
  end
end
