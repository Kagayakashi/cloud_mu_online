class TeleportsController < ApplicationController
  def new
    @maps = Map.all
  end

  def create
    begin
      map = Map.find(params[:id])
      if map.min_level >= active_character.level && map.teleport_cost.zero?
        active_character.map = map
        active_character.save
        redirect_to map_path, notice: "Teleported to #{ map.name }."
      else
        redirect_to new_teleport_path, alert: "Failed to teleport."
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to new_teleport_path, alert: "Cannot teleport to unknown map."
    end
  end
end
