class CreateWildlifeLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :wildlife_locations do |t|
      t.string :name
      t.decimal :latitude
      t.decimal :longitude
      t.st_point :geom, geographic: true
      t.index :geom, using: :gist

      t.timestamps
    end
  end
end
