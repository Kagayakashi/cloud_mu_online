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
    Rails.logger.info "Monster going to hit #{@character.name} #{monster_attacks} times"
    monster_attacks.times do
      Rails.logger.info "Monster performing attack"
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
    MonsterPerformAttackJob.perform_in(10.seconds, @monster.id, @character.id)
  end

  def perform_attack
    Rails.logger.info "#{ @character.name } current health is #{ @character.current_health }"

    return unless @character.current_health > 0

    hit_chance = calculate_hit_chance(attack_rate: @monster_type.attack_rate, defense_rate: @player_defense_rate)

    return unless attack_success?(hit_chance)

    Rails.logger.info "Monster attack is success"

    damage = calculate_damage(min_attack: @monster_type.min_attack, max_attack: @monster_type.max_attack, defense: @player_defense)

    Rails.logger.info "Monster damage is #{ damage }"

    return unless damage > 0

    @damage += damage
    @character.current_health -= damage

    return if @character.current_health <= 0
  end

  def attack_result
    if @character.current_health <= 0
      Rails.logger.info "Player is dead"
      @monster.update(target: nil)
      @character.update(current_health: 0, map: Map.first)
      InGameLogs::DamageReceivedLog.create(character: @character, description: "#{@monster_type.name} killed you.")
      return
    else
      attack_later
      Rails.logger.info "Player is not dead"
      InGameLogs::DamageReceivedLog.create(character: @character, description: "#{@monster_type.name} dealt #{@damage} damage to you.") if @damage > 0
    end
  end
end
