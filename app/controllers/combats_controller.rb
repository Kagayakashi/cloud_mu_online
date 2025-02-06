class CombatsController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  def create
    target = Characters::Character.find(params[:character_id])
    CombatService.call(player: active_character, target: target)
    redirect_to combat_path
  end

  def show
    @logs = active_character.game_logs.order(created_at: :desc).limit(25)
  end
end
