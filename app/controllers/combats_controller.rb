class CombatsController < ApplicationController
  def create
    target = Characters::Character.find(params[:character_id])
    CombatService.call(player: Current.character, target: target)
    redirect_to combat_path(monster_id: target)
  end

  def show
    @logs = Current.character.game_logs.order(created_at: :desc).limit(25)
    @monster = Characters::Character.find(params[:monster_id])
  end
end
