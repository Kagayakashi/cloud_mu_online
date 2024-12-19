module CombatService
  class Engagement
    attr_reader :hit_count, :damage, :total_damage, :defender_health

    def self.call(attacker:, defender:, session:)
      instance = new(attacker: attacker, defender: defender, session: session)
      instance.attack
      instance
    end

    def initialize(attacker:, defender:, session:)
      @defender = defender
      @attack_delay = AttackDelay.new(session)
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
      @defender_health = defender.health
      @hit_count = 0
      @total_damage = 0
    end

    def attack
      return @damage = nil unless @attack_delay.can_attack?
      return @damage = nil unless @defender.health > 0

      @attack_speed.times do
        break if @defender.health <= 0

        if @hit_calculation.hit?
          @hit_count += 1
          @damage = @dmg_calculation.damage

          if @damage > 0
            @defender.health -= damage
            @total_damage += damage
          end
        end
      end

      @attack_delay.set_delay
      @defender_health = [ @defender.health, 0 ].max
    end
  end
end
