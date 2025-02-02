class WildlifeLocationsController < ApplicationController
  def index
    if params[:search_location].present? && params[:radius].present?
      results = Geocoder.search(params[:search_location])
      if results.present?
        lat = results.first.latitude
        lon = results.first.longitude
        radius_meters = params[:radius].to_f * 1000
        @wildlife_locations = WildlifeLocation.nearby(lat, lon, radius_meters)
      else
        @wildlife_locations = WildlifeLocation.none
      end
    else
      @wildlife_locations = WildlifeLocation.all
    end

    respond_to do |format|
      format.turbo_stream
      format.html
      format.json { render json: @wildlife_locations }
    end
  end

  def create
    @wildlife_location = WildlifeLocation.new(location_params)
    if @wildlife_location.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to wildlife_locations_path, notice: "Site added." }
      end
    else
      render json: @wildlife_location.errors, status: :unprocessable_entity
    end
  end

  private

  def location_params
    params.require(:wildlife_location).permit(:name, :latitude, :longitude)
  end
end
