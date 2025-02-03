class WildlifeLocationsController < ApplicationController
  def index
    @wildlife_locations = WildlifeLocation.all

    # Process search only if both location and radius parameters are provided
    if params[:search_location].present? && params[:radius].present?
      results = Geocoder.search(params[:search_location])
      if results.present?
        @center_lat = results.first.latitude
        @center_lon = results.first.longitude
        radius_meters = params[:radius].to_f * 1000
        @nearby_locations = WildlifeLocation.nearby(@center_lat, @center_lon, radius_meters)
        flash.now[:notice] = "No conservation sites found nearby." if @nearby_locations.empty?
      else
        flash.now[:alert] = "Location not found. Please enter a valid location."
        load_default_locations
      end
    else
      # Handle invalid or missing search parameters
      if params[:search_location].present? || params[:radius].present?
        flash.now[:alert] = "Please enter a valid location and radius."
      end
      load_default_locations
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
        format.html { redirect_to wildlife_locations_path, notice: "Conservation site added." }
      end
    else
      flash.now[:alert] = @wildlife_location.errors.full_messages.to_sentence
      @wildlife_locations = WildlifeLocation.all
      render :index, status: :unprocessable_entity
    end
  end

  private

  # Fallback to default location (entire UK) and all sites
  def load_default_locations
    @wildlife_locations = WildlifeLocation.all
    @center_lat = 54.0
    @center_lon = -2.0
  end

  def location_params
    params.require(:wildlife_location).permit(:name, :latitude, :longitude)
  end
end
