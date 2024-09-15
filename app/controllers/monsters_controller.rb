class MonstersController < ApplicationController
  # ToDo
  def receive_spell_damage
    @monster = Monster.find(params[:id])
  end

  def receive_attack_damage
    if active_character.attack_delay_left > 0
      return redirect_to adventure_path, alert: "You cannot attack to fast."
    end

    begin
      @monster = Monster.find(params[:id])
      total_damage = 0
      calculate_player_attack_speed.times do
        if @monster.health <= 0
          return redirect_to adventure_path, alert: "Monster is dead. Failed to apply attack."
        end

        player_attack_rate = CharacterTypes::DarkWizard.calculate_attack_rate(active_character)

        hit_chance = calculate_hit_chance(
          attack_rate: player_attack_rate,
          defense_rate: @monster.monster_type.defense_rate
        )

        unless attack_success?(hit_chance)
          next
        end

        damage = calculate_damage(@monster.monster_type.defense)
        total_damage += damage

        unless damage > 0
          next
        end

        @monster.health -= damage
        active_character.set_attack_delay

        if @monster.health <= 0
          @monster.destroy
          spawn_monster_later(@monster)
          experience = active_character.add_experience_from_monster!(@monster.monster_type)
          return redirect_to adventure_path, notice: "#{ @monster.monster_type.name } dead. Reward is #{experience} experience."
        else
          @monster.save
          next
        end
      end

      notice = "You hit #{ @monster.monster_type.name } with #{ total_damage } damage." if total_damage > 0
      notice = "You cannot break #{ @monster.monster_type.name } defense." if total_damage <= 0

      return redirect_to adventure_path, notice: notice
    rescue ActiveRecord::RecordNotFound
      redirect_to adventure_path, alert: "Failed to attack. Monaster do not exist."
    end
  end

  private

  # Amount of attacks, depends on attack speed
  def calculate_player_attack_speed
    attacks = 2
    attacks
  end

  def calculate_monster_attack_speed
    attacks = 1
    attacks
  end

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

  def deal_attack_damage
    #todo
    calculate_monster_attack_speed.times do
      damage = damage = rand(@monster.monster_type.min_attack..@monster.monster_type.max_attack)
      damage -= active_character.defense

      next unless damage > 0

      player_defense_rate = CharacterTypes::DarkWizard.calculate_defense_rate(active_character)

      hit_chance = calculate_hit_chance(
        attack_rate: @monster.monster_type.attack_rate,
        defense_rate: player_defense_rate
      )

      unless attack_success?(hit_chance)
        next
      end



    end
  end

  def spawn_monster_later(monster)
    monster.destroy
    spawn_at = Time.now + monster.monster_type.spawn_time
    SpawnMonsterJob.perform_at(spawn_at, monster.monster_type.id)
  end

  # ToDo
  # Excellent Hit *1.2
  # Critical Hit maxDmg
  # Double Damage *2
  # Ignore Defense
end
