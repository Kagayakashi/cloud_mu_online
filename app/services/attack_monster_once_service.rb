class AttackMonsterOnceService.rb
  include AttackCalculations

  def initialize(monster:, character:)
    @monster = monster
    @monster_type = monster.monster_type

    #@player_defense_rate = character.character_type.calculate_defense_rate(character)
    @player_attack_rate = character.character_type.calculate_attack_rate(character)
    @player_min_attack = character.character_type.calculate_min_attack(character)
    @player_max_attack = character.character_type.calculate_max_attack(character)

    # total damage dealt to read
    @damage = 0
  end

  def call
    player_attacks.times do
      attack
    end
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

  def attack
    return unless @monster.health > 0

    hit_chance = calculate_hit_chance(
      attack_rate: @player_attack_rate,
      defense_rate: @monster_type.defense_rate
    )

    return unless attack_success?(hit_chance)

    damage = calculate_damage(@monster_type.defense)
    @damage += damage

    return unless damage > 0

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

    return redirect_to adventure_path, notice: notice
  end
end