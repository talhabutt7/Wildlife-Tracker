# spec/controllers/wildlife_locations_controller_spec.rb
require 'rails_helper'

RSpec.describe WildlifeLocationsController, type: :controller do
  let!(:location) { WildlifeLocation.create(name: "London Zoo", latitude: 51.5353, longitude: -0.1557) }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new wildlife location" do
        expect {
          post :create, params: { wildlife_location: { name: "New Site", latitude: 52.0, longitude: -1.0 } }
        }.to change(WildlifeLocation, :count).by(1)
      end
    end
  end
end