class TeleportsController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  # TODO, show only available
  def new
    @maps = Map.teleportable
  end

  def create
    begin
      map = Map.find(params[:id])
      if map.min_level >= active_character.level && map.teleport_cost <= 0
        active_character.map = map
        active_character.save
        redirect_to map_path, notice: "Teleported to #{ map.name }."
      else
        redirect_to new_teleport_path, alert: "Your level or zen is not enough to teleport there."
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to new_teleport_path, alert: "Cannot teleport to unknown map."
    end
  end
end
