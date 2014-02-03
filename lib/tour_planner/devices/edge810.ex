defmodule Edge810 do

  def write_waypoints(waypoints) do
    rm_locations
    File.write("/Volumes/USB COPIER 1/Garmin/NewFiles/Waypoints.gpx", waypoints)
  end

  defp rm_locations do
    File.rm "/Volumes/GARMIN/Garmin/Locations/Locations.fit"
  end

end
