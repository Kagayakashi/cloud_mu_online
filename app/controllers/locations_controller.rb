class LocationsController < ApplicationController
  def show
    begin
      @location = Location.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to adventure_path, alert: "Location not found."
    end
  end
end
