class SpotMonstersController < ApplicationController
  # ToDo
  def receive_spell_damage
    spot_monster = SpotMonster.find(params[:id])
  end

  def receive_attack_damage
    begin
      spot_monster = SpotMonster.find(params[:id])

      if spot_monster.health <= 0
        return redirect_to spot_path, alert: "Monster is dead. Failed to apply attack."
      end

      player_attack_rate = CharacterTypes::DarkWizard.calculate_attack_rate(active_character)

      hit_chance = calculate_hit_chance(
        attack_rate: player_attack_rate,
        defense_rate: spot_monster.monster.defense_rate
      )

      unless attack_success?(hit_chance)
        return redirect_to spot_path, notice: "You missed hit to #{ spot_monster.monster.name }."
      end

      damage = calculate_damage(spot_monster.monster.defense)

      unless damage > 0
        return redirect_to spot_path, notice: "Your hit deals no damage to #{ spot_monster.monster.name }."
      end

      spot_monster.health -= damage

      if spot_monster.health <= 0
        spot_monster.destroy
        spawn_monster_later(spot_monster)
        experience = active_character.add_experience_from_monster!(spot_monster.monster)
        return redirect_to spot_path, notice: "#{ spot_monster.monster.name } dead. Reward is #{experience} experience."
      else
        spot_monster.save
        return redirect_to spot_path, notice: "You hit #{ spot_monster.monster.name } with #{ damage } damage."
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to spot_path, alert: "Failed to attack. Monaster do not exist."
    end
  end

  private

  # ToDo move calculation logic into service
  def calculate_hit_chance(attack_rate:, defense_rate:)
    hit_chance = 0.03
    if defense_rate < attack_rate
      hit_chance = 1.00 - (defense_rate.to_f/attack_rate).round(2)
    end
    hit_chance
  end

  def attack_success?(hit_chance)
    threshold = rand(0.01..1.00).round(2)
    hit_chance >= threshold
  end

  def calculate_damage(monster_defense)
    player_min_attack = CharacterTypes::DarkWizard.calculate_min_attack(active_character)
    player_max_attack = CharacterTypes::DarkWizard.calculate_max_attack(active_character)

    damage = rand(player_min_attack..player_max_attack)
    damage -= monster_defense
  end

  def spawn_monster_later(spot_monster)
    spot_monster.destroy
    spawn_at = Time.now + spot_monster.monster.spawn_time
    SpawnMonsterJob.perform_at(spawn_at, spot_monster.monster.id, spot_monster.spot.id)
  end

  # ToDo
  # Excellent Hit *1.2
  # Critical Hit maxDmg
  # Double Damage *2
  # Ignore Defense
end
