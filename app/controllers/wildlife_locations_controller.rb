class WildlifeLocationsController < ApplicationController
  def index
    if params[:latitude] && params[:longitude] && params[:radius]
      @locations = WildlifeLocation.nearby(params[:latitude].to_f, params[:longitude].to_f, params[:radius].to_i)
    else
      @locations = WildlifeLocation.all
    end

    respond_to do |format|
      format.turbo_stream
      format.html
      format.json { render json: @locations }
    end
  end

  def create
    location = WildlifeLocation.new(location_params)
    if location.save
      render turbo_stream: turbo_stream.append("locations", partial: "locations/location", locals: { location: location })
    else
      render json: location.errors, status: :unprocessable_entity
    end
  end

  private

  def location_params
    params.require(:wildlife_location).permit(:name, :latitude, :longitude)
  end
end