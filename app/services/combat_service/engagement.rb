module CombatService
  class Engagement
    attr_reader :success, :message, :hit_count, :damage, :total_damage, :defender_health

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
      @defender_health = defender.health
      @hit_count = 0
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
      @hit_count += 1
      @damage = @dmg_calculation.damage

      if @damage > 0
        apply_damage
      end
    end

    def apply_damage
      @defender.health -= @damage
      @total_damage += @damage
      @defender_health = [ @defender.health, 0 ].max
    end

    def finalize_attack
      @success = true
      @attack_delay.set_delay
      @defender.save if @defender.changed?
      MonsterReaction.call(monster: @defender, character: @attacker)
    end
  end
end
