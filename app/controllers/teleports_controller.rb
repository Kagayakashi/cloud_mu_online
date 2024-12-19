class TeleportsController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  def new
    @maps = Map.teleportable
  end

  def create
    map = Map.find_by(id: params[:id])

    return redirect_to new_teleport_path, alert: "Cannot teleport to unknown map." unless map

    alert = teleport_error(map)
    if alert
      redirect_to new_teleport_path, alert: alert
    else
      active_character.update(map: map, gold: active_character.gold - map.teleport_cost)
      redirect_to adventure_path, notice: "Teleported to #{map.name}."
    end
  end

  private

  def teleport_error(map)
    return "You cannot teleport to #{map.name}." unless map.can_teleport
    return "Your level is too low to teleport to #{map.name}." if map.min_level > active_character.level
    "You have not enough gold to teleport to #{map.name}." if map.teleport_cost > active_character.gold
  end
end
