# spec/features/user_interaction_spec.rb
require 'rails_helper'

RSpec.feature "Wildlife Locations", type: :feature do
  scenario "User adds a new conservation site" do
    visit root_path
    fill_in "Name", with: "Amazon Rainforest"
    fill_in "Latitude", with: "-3.4653"
    fill_in "Longitude", with: "-62.2159"
    click_button "Add Conservation Site"
    expect(page).to have_content("Amazon Rainforest")
  end

  scenario "User searches for a location and radius" do
    visit root_path
    fill_in "search_location", with: "London"
    fill_in "radius", with: "10"
    click_button "Search"
    expect(page).to have_content("No conservation sites found nearby.")
  end
end