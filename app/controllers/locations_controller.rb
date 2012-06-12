class LocationsController < ApplicationController

  respond_to :html, :json

  def index
    @locations = Location.all
    respond_with(@locations)
  end

end
