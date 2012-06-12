class LocationsController < ApplicationController

  respond_to :html, :json

  def index
    @locations = Location.all
    respond_with(@locations)
  end

  def create
    location = Location.create(location_params)

    respond_with(location)
  end

  def destroy
    location = Location.where(position: location_params[:position]).destroy

    respond_with(location)
  end

  private

  def location_params
    params[:location]
  end

end
