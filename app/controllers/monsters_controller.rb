class MonstersController < ApplicationController
  before_action :set_monster

  include AttackDelay

  def receive_spell_damage
  end

  def receive_attack_damage
    if attack_delay_left > 0
      return redirect_to adventure_path, alert: "You cannot attack so fast."
    end

    if active_character.activity.zero?
      return redirect_to adventure_path, alert: "You need to rest."
    end

    attack_service = AttackMonsterOnceService.new(monster: @monster, character: active_character)
    attack_service.call

    set_attack_delay

    redirect_to adventure_path
  end

  private

  def set_monster
    @monster = Monster.lock("FOR UPDATE").find(params[:id])
  end
end
