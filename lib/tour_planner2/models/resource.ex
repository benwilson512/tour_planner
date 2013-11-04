defmodule Resource do
  use Ecto.Model
  use TourPlanner.Model

  queryable "resources" do
    field :google_id,   :string
    field :places_ref,  :string
    field :name,        :string
    field :address,     :string
    field :lat,         :float
    field :lon,         :float
    field :price_level, :integer
    field :rating,      :float
    field :types,       :string
    field :created_at,  :datetime
    field :updated_at,  :datetime
  end

end
