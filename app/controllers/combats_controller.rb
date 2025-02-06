class CombatsController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  def new
    map = active_character.map
    @monster = map.monsters.first
    @paths = map.connected_maps
  end

  def create
    monster = MonsterType.find(params[:monster_type_id])
    CombatService::QuickCombat.call(player: active_character, target: monster)
    redirect_to combat_path
  end

  def show
    @logs = active_character.game_logs.order(created_at: :desc).limit(50)
  end
end
