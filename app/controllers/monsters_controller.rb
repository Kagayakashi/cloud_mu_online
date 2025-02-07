class MonstersController < ApplicationController
  before_action :set_monster

  def receive_spell_damage
  end

  def receive_attack_damage
    combat = CombatService.call(attacker: Current.character, defender: @monster, session: session)

    if combat.success
      redirect_to adventure_path
    else
      redirect_to adventure_path, alert: combat.message
    end
  end

  private

  def set_monster
    @monster = Monster.lock("FOR UPDATE").find(params[:id])
  end
end
