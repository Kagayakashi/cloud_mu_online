module CombatService
  class PerformAttack
    def self.call(attacker:, defender:)
      new(attacker: attacker, defender: defender).perform
    end

    def initialize(attacker:, defender:)
      @hit_calculation = HitCalculation.new(
        attack_rate: attacker.attack_rate,
        defense_rate: defender.defense_rate
      )
      @dmg_calculation = DamageCalculation.new(
        min_attack: attacker.min_attack,
        max_attack: attacker.max_attack,
        defense: defender.defense_rate
      )
      @attacks = attacker.attacks
      @defender_health = defender.current_health
      @hit_count = 0
      @total_damage = 0
    end

    def perform
      @attacks.times do
        break if @defender_health <= 0
        if @hit_calculation.hit?
          @hit_count += 1
          damage = @dmg_calculation.damage

          if damage > 0
            @defender_health -= damage
            @total_damage += damage
          end
        end
      end

      @defender_health = [@defender_health, 0].max

      Result.new(
        hit_count: @hit_count,
        total_damage: @total_damage,
        defender_health: @defender_health
      )
    end
  end
end
