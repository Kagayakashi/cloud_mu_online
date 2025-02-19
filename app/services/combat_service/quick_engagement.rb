module CombatService
  class QuickEngagement
    def self.call(attacker:, defender:)
      instance = new(attacker: attacker, defender: defender)
      instance.attack
      instance
    end

    def initialize(attacker:, defender:)
      @attacker = attacker
      @defender = defender
      @hit_calculation = HitCalculation.new(
        attack_rate: attacker.attack_rate,
        defense_rate: defender.defense_rate
      )
      @dmg_calculation = DamageCalculation.new(
        min_attack: attacker.min_attack,
        max_attack: attacker.max_attack,
        defense: defender.defense
      )
    end

    def attack
      @attacker.attacks.times do
        break if @defender.hp <= 0

        if @hit_calculation.hit?
          handle_hit
        end
      end
    end

    private

    def handle_hit
      damage = @dmg_calculation.damage
      apply_damage(damage) if damage > 0
    end

    def log_hit(damage)
      if @attacker.is_a? Characters::Player
        GameLogs::DamageDealtLog.create(
          character: @attacker,
          description: "You dealt #{ damage } damage."
        )
      end

      if @defender.is_a? Characters::Player
        GameLogs::DamageReceivedLog.create(
          character: @defender,
          description: "You received #{ damage } damage."
        )
      end
    end

    def apply_damage(damage)
      @defender.hp -= damage
      log_hit(damage)
      @defender.hp = [ @defender.hp, 0 ].max
    end
  end
end
