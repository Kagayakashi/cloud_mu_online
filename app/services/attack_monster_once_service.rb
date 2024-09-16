class AttackMonsterOnceService
  include AttackCalculations

  def initialize(monster:, character:)
    @monster = monster
    @monster_type = monster.monster_type

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

  def monster_attack
    attacks = 1
    attacks
  end

  def spawn_monster_later(monster)
    monster.destroy
    spawn_at = Time.now + monster.monster_type.spawn_time
    SpawnMonsterJob.perform_at(spawn_at, monster.monster_type.id)
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

    @monster.save
  end

  def attack_result
    damage_dealt = @damage
    monster_killed = @monster.health <= 0

    if monster_killed
      @monster.destroy
      spawn_monster_later(@monster)
    end

    AttackMonsterResult.new(
      damage_dealt: damage_dealt,
      monster_killed: monster_killed,
    )
  end
end
