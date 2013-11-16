defmodule Resource do
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
    # field :created_at,  :datetime
    # field :updated_at,  :datetime
  end

  def find_duplicates do
    Resource.all
      |> Enum.map(&find_dups(&1))
      |> List.flatten
  end

  def find_dups(resource) do
    Repo.all(from r in Resource, where: r.places_ref == ^resource.places_ref, select: r)
      |> List.delete(resource)
  end

end
