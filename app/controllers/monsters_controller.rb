class MonstersController < ApplicationController
  before_action :set_monster

  def receive_spell_damage
  end

  def receive_attack_damage
    if active_character.attack_delay_left > 0
      return redirect_to adventure_path, alert: "You cannot attack so fast."
    end

    attack_service = AttackMonsterOnceService.new(monster: @monster, character: active_character)
    result = attack_service.call

    active_character.set_attack_delay

    if result.monster_killed
      experience = active_character.add_experience_from_monster!(@monster.monster_type)
      redirect_to adventure_path, notice: "#{ @monster.monster_type.name } dead. Reward is #{experience} experience."
    else
      redirect_to adventure_path, notice: "You deal #{result.damage_dealt} damage to spider"
    end
  end

  private

  def set_monster
    @monster = Monster.lock("FOR UPDATE").find(params[:id])
  end
end
