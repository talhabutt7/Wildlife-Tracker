# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_02_02_023742) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "wildlife_locations", force: :cascade do |t|
    t.string "name"
    t.decimal "latitude"
    t.decimal "longitude"
    t.geography "geom", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geom"], name: "index_wildlife_locations_on_geom", using: :gist
  end

end
