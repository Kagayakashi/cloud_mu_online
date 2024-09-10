class SpotsController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  def show
    @spot_monsters = player.spot.spot_monsters
  end

  def activate
    logger.debug(params)
    begin
      spot = Spot.find(params[:id])
      player.spot = spot
      if player.save
        redirect_to spot_path, notice: "Moved to #{ spot.name }."
      else
        redirect_to map_path, alert: "Failed to change spot."
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to map_path, alert: "Cannot go to unknown spot."
    end
  end
end
