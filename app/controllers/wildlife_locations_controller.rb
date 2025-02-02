class WildlifeLocationsController < ApplicationController
  def index
    if params[:search_location].present? || params[:radius].present?
      # Validate that both search_location and radius are provided
      if params[:search_location].blank? || params[:radius].blank?
        flash.now[:alert] = "Please enter a valid location and radius."
        @wildlife_locations = WildlifeLocation.all
        @center_lat = 54.0
        @center_lon = -2.0
      else
        results = Geocoder.search(params[:search_location])
        if results.present?
          @center_lat = results.first.latitude
          @center_lon = results.first.longitude
          radius_meters = params[:radius].to_f * 1000
          @wildlife_locations = WildlifeLocation.nearby(@center_lat, @center_lon, radius_meters)
          flash.now[:notice] = "No conservation sites found nearby." if @wildlife_locations.empty?
        else
          flash.now[:alert] = "Location not found. Please enter a valid location."
          @wildlife_locations = WildlifeLocation.all
          @center_lat = 54.0
          @center_lon = -2.0
        end
      end
    else
      @wildlife_locations = WildlifeLocation.all
      @center_lat = 54.0
      @center_lon = -2.0
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
      # Render errors for the form submission without reloading the page
      flash.now[:alert] = @wildlife_location.errors.full_messages.to_sentence
      @wildlife_locations = WildlifeLocation.all
      render :index, status: :unprocessable_entity
    end
  end

  private

  def location_params
    params.require(:wildlife_location).permit(:name, :latitude, :longitude)
  end
end
