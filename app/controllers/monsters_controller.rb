class MonstersController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!
  before_action :set_monster

  def receive_spell_damage
  end

  def receive_attack_damage
    CombatService::Engagement.call(attacker: active_character, defender: @monster.monster_type, session: session)
    redirect_to adventure_path
  end

  private

  def set_monster
    @monster = Monster.lock("FOR UPDATE").find(params[:id])
  end
end
