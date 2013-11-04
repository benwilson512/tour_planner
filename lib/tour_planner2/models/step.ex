defmodule Step do
  use Ecto.Model
  use Model.Attributes

  queryable "steps" do
    belongs_to :route, Route

    field :start_lat,     :float
    field :start_lon,     :float
    field :end_lat,       :float
    field :end_lon,       :float
    field :distance,      :integer
    field :instructions,  :string
    field :created_at,    :datetime
    field :updated_at,    :datetime
  end
end
