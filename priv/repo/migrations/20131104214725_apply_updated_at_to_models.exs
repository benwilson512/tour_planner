defmodule Repo.Migrations.ApplyUpdatedAtToModels do
  use Ecto.Migration

  def up do
    [
      "CREATE TRIGGER route_updated_at BEFORE UPDATE ON routes FOR EACH ROW EXECUTE PROCEDURE update_at_column();",
      "CREATE TRIGGER step_updated_at BEFORE UPDATE ON steps FOR EACH ROW EXECUTE PROCEDURE update_at_column();",
      "CREATE TRIGGER resources_updated_at BEFORE UPDATE ON resources FOR EACH ROW EXECUTE PROCEDURE update_at_column();"
    ]
  end

  def down do
    [
      "DROP TRIGGER route_updated_at ON routes;",
      "DROP TRIGGER step_updated_at ON steps;",
      "DROP TRIGGER resources_updated_at ON resources;"
    ]
  end
end
