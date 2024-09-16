class MonsterAggroService
  include AttackCalculations

  def initialize(monster:, character:)
    @monster = monster
    @monster_type = monster.monster_type
    @character = character

    @player_defense_rate = @character.character_type.calculate_defense_rate(@character)
    @player_defense = @character.character_type.calculate_defense(@character)

    # total damage dealt
    @damage = 0
  end

  def call
    monster_attacks.times do
      perform_attack
    end

    @character.save! if @character.changed?

    attack_result
  end

  private

  # Amount of attacks, depends on attack speed
  def monster_attacks
    attacks = 1
    attacks
  end

  def attack_later
    MonsterPerformAttackJob.perform_in(5.seconds, @monster.id, @character.id)
  end

  def perform_attack
    return unless @character.current_health > 0

    hit_chance = calculate_hit_chance(attack_rate: @monster_type.attack_rate, defense_rate: @player_defense_rate)
    return unless attack_success?(hit_chance)

    damage = calculate_damage(min_attack: @monster_type.min_attack, max_attack: @monster_type.max_attack, defense: @player_defense)

    return unless damage > 0

    @damage += damage
    @character.current_health -= damage

    return if @character.current_health <= 0
  end

  def attack_result
    damage_dealt = @damage
    target_killed = @character.current_health <= 0

    if target_killed
      @monster.update(target: nil)
      @character.current_health = 0
      @character.map = Map.first
    else
      attack_later
    end

    AttackResult.new(
      damage_dealt: damage_dealt,
      target_killed: target_killed,
    )
  end
end
