module CombatService
  class QuickEngagement
    def self.call(attacker:, defender:)
      instance = new(attacker, defender)
      instance.attack
      instance
    end

    def initialize(attacker, defender)
      @attacker = attacker
      @defender = defender
    end

    def attack
      accuracy = accuracy_handler
      attack = damage_handler

      @attacker.attacks.times do
        if accuracy.hit?
          damage = attack.damage

          if damage > 0
            apply_damage(damage)
          else
            log_zero
          end
        else
          log_miss
        end
      end
    end

    private

    def accuracy_handler
      HitCalculation.new(
        attack_rate: @attacker.attack_rate,
        defense_rate: @defender.defense_rate
      )
    end

    def damage_handler
      DamageCalculation.new(
        min_attack: @attacker.min_attack,
        max_attack: @attacker.max_attack,
        defense: @defender.defense
      )
    end

    def apply_damage(damage)
      @defender.health = [ @defender.health - damage, 0 ].max
      log_hit(damage)
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

    def log_miss
      if @attacker.is_a? Characters::Player
        GameLogs::DamageDealtLog.create(
          character: @attacker,
          description: "You missed an attack."
        )
      end

      if @defender.is_a? Characters::Player
        GameLogs::DamageReceivedLog.create(
          character: @defender,
          description: "You dodged an attack."
        )
      end
    end

    def log_zero
      if @attacker.is_a? Characters::Player
        GameLogs::DamageDealtLog.create(
          character: @attacker,
          description: "You attacked, but it had no effect."
        )
      end

      if @defender.is_a? Characters::Player
        GameLogs::DamageReceivedLog.create(
          character: @defender,
          description: "You absorbed an attack."
        )
      end
    end
  end
end
