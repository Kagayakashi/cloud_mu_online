class MonstersController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!
  before_action :set_monster

  def receive_spell_damage
  end

  def receive_attack_damage
    combat = CombatService::Engagement.call(attacker: active_character, defender: @monster, session: session)
    @monster.update(target: active_character)

    if combat.defender_health > 0 && combat.damage.nil?
      return redirect_to adventure_path, alert: "You cannot attack so fast."
    end

    redirect_to adventure_path
  end

  private

  def set_monster
    @monster = Monster.lock("FOR UPDATE").find(params[:id])
  end
end
