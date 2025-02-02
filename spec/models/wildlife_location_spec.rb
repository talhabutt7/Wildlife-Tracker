# spec/models/wildlife_location_spec.rb
require 'rails_helper'

RSpec.describe WildlifeLocation, type: :model do
  it "is valid with a name, latitude, and longitude" do
    location = WildlifeLocation.new(name: "Test Site", latitude: 51.5074, longitude: -0.1278)
    expect(location).to be_valid
  end

  it "is invalid without a name" do
    location = WildlifeLocation.new(latitude: 51.5074, longitude: -0.1278)
    expect(location).not_to be_valid
  end
end