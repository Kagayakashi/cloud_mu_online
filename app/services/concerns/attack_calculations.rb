# automatic loaded in services if included
module AttackCalculations
  def calculate_hit_chance(attack_rate:, defense_rate:)
    hit_chance = 0.03
    if defense_rate < attack_rate
      hit_chance = 1.00 - (defense_rate.to_f / attack_rate).round(2)
    end
    hit_chance
  end

  def attack_success?(hit_chance)
    threshold = rand(0.01..1.00).round(2)
    hit_chance >= threshold
  end

  def calculate_damage(min_attack:, max_attack:, defense:)
    damage = rand(min_attack..max_attack)
    damage -= defense
    [damage, 0].max
  end
end
