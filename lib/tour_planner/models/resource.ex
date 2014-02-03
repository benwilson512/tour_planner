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
    field :created_at,  :datetime
    field :updated_at,  :datetime

    def find_dups(resource) do
      Repo.all(from r in Resource, where: r.places_ref == ^resource.places_ref, select: r)
        |> List.delete(resource)
    end

    def to_gpx_waypoint(resource) do
      """
     <wpt lat="#{resource.lat}" lon="#{resource.lon}">
        <name>#{resource.name}</name>
        <type>#{resource.types}</type>
     </wpt>
      """
    end
  end

  def find_duplicates do
    Resource.all
      |> Enum.map(&(&1.find_dups))
      |> List.flatten
  end

  def gpx_waypoints(resources) do
    header = """
      <?xml version="1.0" encoding="UTF-8" standalone="no"?>
      <gpx
      xmlns="http://www.topografix.com/GPX/1/1"
      xmlns:gpxx = "http://www.garmin.com/xmlschemas/GpxExtensions/v3"
      xmlns:xsi = "http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd
      http://www.garmin.com/xmlschemas/GpxExtensions/v3
      http://www8.garmin.com/xmlschemas/GpxExtensions/v3/GpxExtensionsv3.xsd"
      version="1.1"
      creator="gpx-poi.com">
      """

    points = resources
      |> Enum.map(&(&1.to_gpx_waypoint))
      |> Enum.join("\n")

    header <> points <> "</gpx>"
  end

end
