class AdventuresController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  def show
    @map = active_character.map
    @monsters = @map.monsters
    @paths = @map.connected_maps
    @logs = active_character.in_game_logs.order(created_at: :desc).limit(10)
  end

  def travel
    map = Map.find(params[:id])
    active_character.map = map
    if active_character.save
      redirect_to adventure_path
    end
  end
end
