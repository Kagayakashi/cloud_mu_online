module CombatService
  class Engagement
    attr_reader :success, :message, :damage, :total_damage

    def self.call(attacker:, defender:, session:)
      instance = new(attacker: attacker, defender: defender, session: session)
      instance.attack
      instance
    end

    def initialize(attacker:, defender:, session:)
      @attacker = attacker
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
      @total_damage = 0
      @success = false
      @message = ""
    end

    def attack
      return unless can_attack?

      @attacker.attacks.times do
        break if @defender.health <= 0

        if @hit_calculation.hit?
          handle_hit
        end
      end

      finalize_attack
    end

    private

    def can_attack?
      unless @attack_delay.can_attack?
        @message = "You cannot attack so often."
        return false
      end

      return true if @defender.health > 0

      @message = "Target is already defeated."
      false
    end

    def handle_hit
      damage = @dmg_calculation.damage
      apply_damage(damage) if damage > 0
    end

    def apply_damage(damage)
      @defender.health -= damage
      @total_damage += damage
      @defender.health = [ @defender.health, 0 ].max
    end

    def finalize_attack
      if @total_damage > 0
        @success = true
        @attack_delay.set_delay

        if @attacker.is_a? Characters::Character
          GameLogs::DamageDealtLog.create(character: @attacker, description: "You dealt #{@total_damage} damage to #{@defender.name}.")
        end
        if @defender.is_a? Characters::Character
          GameLogs::DamageReceivedLog.create(character: @defender, description: "You received #{@total_damage} damage from #{@attacker.name}.")
        end

        if @attacker.is_a?(Characters::Character) && @defender.is_a?(Monster)
          MonsterReaction.call(monster: @defender, character: @attacker)
        end
      end
    end
  end
end
