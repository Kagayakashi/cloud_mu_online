class AdventuresController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  include AttackDelay

  def show
    @map = active_character.map
    @monsters = @map.monsters
    @paths = @map.connected_maps
    @logs = active_character.game_logs.order(created_at: :desc).limit(10)
    @attack_delay = attack_delay_left
  end

  def travel
    map = Map.find(params[:id])
    active_character.map = map
    if active_character.save
      redirect_to adventure_path
    end
  end
end
