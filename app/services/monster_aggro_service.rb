class MonsterAggroService
  include AttackCalculations

  def initialize(monster:, character:)
    @monster = monster
    @monster_type = monster.monster_type
    @character = character

    @player_defense_rate = @character.calculate_defense_rate
    @player_defense = @character.calculate_defense

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
    MonsterPerformAttackJob.set(wait: 10.seconds).perform_later(@monster.id, @character.id)
  end

  def perform_attack
    return unless @character.health > 0

    hit_chance = calculate_hit_chance(attack_rate: @monster_type.attack_rate, defense_rate: @player_defense_rate)

    return unless attack_success?(hit_chance)

    damage = calculate_damage(min_attack: @monster_type.min_attack, max_attack: @monster_type.max_attack, defense: @player_defense)

    return unless damage > 0

    @damage += damage
    @character.health -= damage

    nil if @character.health <= 0
  end

  def attack_result
    if @character.health <= 0
      @monster.update(target: nil)
      @character.update(health: 1, map: Map.first)
      GameLogs::DamageReceivedLog.create(character: @character, description: "#{@monster_type.name} killed you.")
    else
      attack_later
      GameLogs::DamageReceivedLog.create(character: @character, description: "#{@monster_type.name} dealt #{@damage} damage to you.") if @damage > 0
    end
  end
end
