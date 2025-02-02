class WildlifeLocation < ApplicationRecord
  # Ensure required fields are present
  validates :name, :latitude, :longitude, presence: true

  # Set the PostGIS geometry before saving
  before_save :set_geom

  # Scope to fetch locations within a given radius (meters) from a point
  scope :nearby, ->(lat, lon, radius) {
    where("ST_DWithin(geom, ST_SetSRID(ST_MakePoint(?, ?), 4326)::geography, ?)", lon, lat, radius)
  }

  private

  # Compute and set the PostGIS geometry field based on longitude and latitude
  def set_geom
    self.geom = "SRID=4326;POINT(#{longitude} #{latitude})"
  end
end
