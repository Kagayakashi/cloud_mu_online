module CombatService
  class Engagement
    attr_reader :hit_count, :damage, :total_damage, :defender_health

    def self.call(attacker:, defender:)
      instance = new(attacker: attacker, defender: defender)
      instance.attack
      instance
    end

    def initialize(attacker:, defender:)
      @hit_calculation = HitCalculation.new(
        attack_rate: attacker.attack_rate,
        defense_rate: defender.defense_rate
      )
      @dmg_calculation = DamageCalculation.new(
        min_attack: attacker.min_attack,
        max_attack: attacker.max_attack,
        defense: defender.defense
      )
      @attack_speed = attacker.attacks
      @defender_health = defender.current_health
      @hit_count = 0
      @total_damage = 0
    end

    def attack
      @attack_speed.times do
        break if @defender_health <= 0
        if @hit_calculation.hit?
          @hit_count += 1
          @damage = @dmg_calculation.damage

          if @damage > 0
            @defender_health -= damage
            @total_damage += damage
          end
        end
      end

      @defender_health = [@defender_health, 0].max
    end
  end
end
