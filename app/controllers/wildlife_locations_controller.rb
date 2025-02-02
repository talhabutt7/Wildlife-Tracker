# app/controllers/wildlife_locations_controller.rb
class WildlifeLocationsController < ApplicationController
  def index
    @wildlife_locations = WildlifeLocation.all
    if params[:latitude] && params[:longitude] && params[:radius]
      locations = WildlifeLocation.nearby(params[:latitude].to_f, params[:longitude].to_f, params[:radius].to_i)
    else
      locations = WildlifeLocation.all
    end
    respond_to do |format|
      format.turbo_stream
      format.html
      format.json { render json: locations }
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
