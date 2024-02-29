class SpotMonstersController < ApplicationController
  def receive_spell_damage
    spot_monster = SpotMonster.find(params[:id])
  end

  def receive_attack_damage
    begin
      spot_monster = SpotMonster.find(params[:id])

      player_attack_rate = CharacterTypes::DarkWizard.calculate_attack_rate(active_character)
      player_min_attack = CharacterTypes::DarkWizard.calculate_min_attack(active_character)
      player_max_attack = CharacterTypes::DarkWizard.calculate_max_attack(active_character)
      delim = (player_attack_rate + spot_monster.monster.defense_rate)
      miss_chance = player_attack_rate / delim * 100

      logger.debug("player_attack_rate #{player_attack_rate}")
      logger.debug("defense_rate #{spot_monster.monster.defense_rate}")
      logger.debug("miss_chance #{miss_chance}")

      damage = 0
      hit_chance = rand(100)
      logger.debug("hit_chance #{hit_chance}")
      if hit_chance > miss_chance.floor
        damage = rand(player_min_attack..player_max_attack)
        logger.debug("Player Going to Hit #{ spot_monster.monster.name } with #{ damage } damage")
      end

      if damage > 0
        damage -= spot_monster.monster.defense
        logger.debug("Damage is reduced by #{ spot_monster.monster.defense }")
      end

      if damage > 0
        spot_monster.health -= damage

        logger.debug("Player Hit #{ spot_monster.monster.name } with #{ damage } damage")

        logger.debug("#{ spot_monster.monster.name } left #{ spot_monster.health } health")

        if spot_monster.health <= 0
          if spot_monster.destroy
            logger.debug("#{ spot_monster.monster.name } is dead")
            SpawnMonsterJob.perform_at(
              Time.now+spot_monster.monster.spawn_time,
              spot_monster.monster.id,
              spot_monster.spot.id
            )
            return redirect_to spot_path, notice: "You killed #{ spot_monster.monster.name }."
          end
        end

        spot_monster.save
        if spot_monster.save
          return redirect_to spot_path, notice: "You hit #{ spot_monster.monster.name } with #{ damage } damage."
        else
          return redirect_to spot_path, alert: "Failed to apply attack."
        end
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to spot_path, alert: "Failed to attack. Monaster do not exist."
    end
  end
end
