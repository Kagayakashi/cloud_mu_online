class AdventuresController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @map = active_character.map
    @location = active_character.location || @map
    @locations = @map.locations.peace
  end

  def travel
    current_map = active_character.map

    if params[:location_id].present?
      location = current_map.locations.find_by(id: params[:location_id])
      if location
        active_character.update(location: location)
      else
        flash[:alert] = "You cannot go there."
      end
    else
      active_character.update(location: nil)
    end

    redirect_to adventure_path
  end

  private

  def record_not_found
    redirect_to adventure_path, alert: "Location does not exist."
  end
end
