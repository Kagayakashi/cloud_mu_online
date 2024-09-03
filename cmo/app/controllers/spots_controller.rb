class SpotsController < ApplicationController
  before_action :authenticate_user!
  before_action :active_character!

  def show
    @spot_monsters = active_character.spot.spot_monsters
  end

  def activate
    logger.debug(params)
    begin
      spot = Spot.find(params[:id])
      active_character.spot = spot
      if active_character.save
        redirect_to spot_path, notice: "Moved to #{ spot.name }."
      else
        redirect_to map_path, alert: "Failed to change spot."
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to map_path, alert: "Cannot go to unknown spot."
    end
  end
end
