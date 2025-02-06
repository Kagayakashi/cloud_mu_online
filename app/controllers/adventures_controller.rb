class AdventuresController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @map = active_character.map
    @paths = @map.connected_maps
  end

  def travel
    map = Map.find(params[:id])
    if active_character.map.connected_maps.include?(map)
      active_character.update(map: map)
      redirect_to new_combat_path
    else
      redirect_to new_combat_path, alert: "You cannot go there."
    end
  end

  private

  def record_not_found
    flash[:alert] = "Location does not exist."
    redirect_to new_combat_path
  end
end
