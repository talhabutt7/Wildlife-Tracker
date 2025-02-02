class WildlifeLocation < ApplicationRecord
  validates :name, :latitude, :longitude, presence: true
  before_save :set_geom

  scope :nearby, ->(lat, lon, radius) {
    where("ST_DWithin(geom, ST_SetSRID(ST_MakePoint(?, ?), 4326)::geography, ?)", lon, lat, radius)
  }

  private

  def set_geom
    self.geom = "SRID=4326;POINT(#{longitude} #{latitude})"
  end
end