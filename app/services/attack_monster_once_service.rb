class AttackMonsterOnceService
  include AttackCalculations

  def initialize(monster:, character:)
    @monster = monster
    @monster_type = monster.monster_type
    @character = character

    #@player_defense_rate = character.character_type.calculate_defense_rate(character)
    @player_attack_rate = character.character_type.calculate_attack_rate(character)
    @player_min_attack = character.character_type.calculate_min_attack(character)
    @player_max_attack = character.character_type.calculate_max_attack(character)

    # total damage dealt
    @damage = 0
  end

  def call
    player_attacks.times do
      perform_attack
    end

    attack_result
  end

  private

  # Amount of attacks, depends on attack speed
  def player_attacks
    attacks = 2
    attacks
  end

  def set_aggro
    return if @monster.target
    MonsterPerformAttackJob.perform_async(@monster.id, @character.id)
  end

  def spawn_monster_later(monster)
    monster.destroy
    SpawnMonsterJob.perform_in(1.minutes, monster.monster_type.id)
  end

  def perform_attack
    return unless @monster.health > 0

    hit_chance = calculate_hit_chance(attack_rate: @player_attack_rate, defense_rate: @monster_type.defense_rate)
    return unless attack_success?(hit_chance)

    damage = calculate_damage(min_attack: @player_min_attack, max_attack: @player_max_attack, defense: @monster_type.defense)

    return unless damage > 0

    @damage += damage
    @monster.health -= damage

    return if @monster.health <= 0
  end

  def attack_result
    if @monster.health <= 0
      @monster.destroy
      spawn_monster_later(@monster)
      experience = @character.add_experience_from_monster!(@monster.monster_type)
      InGameLogs::ExperienceGainedLog.create(character: @character, description: "Your received #{experience} experience.")
    else
      set_aggro
      @monster.save! if @monster.changed?
      InGameLogs::DamageDealtLog.create(character: @character, description: "You dealt #{@damage} damage.")
    end
  end
end
