defmodule Repo.Migrations.UpdatedAtFunction do
  use Ecto.Migration

  def up do
    "CREATE OR REPLACE FUNCTION update_at_column()
    RETURNS TRIGGER AS $$
    BEGIN
       NEW.updated_at = now(); 
       RETURN NEW;
    END;
    $$ language 'plpgsql';"
  end

  def down do
    ""
  end
end
