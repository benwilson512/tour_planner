defmodule Repo.Migrations.MarkStepsAsImportant do
  use Ecto.Migration

  def up do
    "ALTER TABLE steps ADD COLUMN important boolean;"
  end

  def down do
    ""
  end
end
