class AdventuresController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @city = Current.character.city
    @locations = @city.locations
  end

  def travel
    current_map = Current.character.map

    if params[:location_id].present?
      location = current_map.locations.find_by(id: params[:location_id])

      if location
        Current.character.update(location: location)
      else
        flash[:alert] = "You cannot go there."
        Current.character.update(location: nil)
      end
    else
      Current.character.update(location: nil)
    end

    redirect_to adventure_path
  end

  private

  def record_not_found
    Current.character.update(location: nil)
    redirect_to adventure_path, alert: "Location does not exist."
  end
end
