module CombatService
  class QuickCombat
    MAX_ROUNDS = 25

    def self.call(player:, target:)
      instance = new(player, target)
      instance.start
      instance
    end

    def initialize(player, target)
      @attacker = player
      @defender = target
    end

    def start
      round = 0
      loop do
        round += 1

        attack

        break if ended?
        break if pvp? && round >= MAX_ROUNDS

        swap_roles
      end

      result
    end

    private

    def pvp?
      @attacker.is_a?(Characters::Player) && @defender.is_a?(Characters::Player)
    end

    def ended?
      @attacker.dead? || @defender.dead?
    end

    def swap_roles
      @attacker, @defender = @defender, @attacker
    end

    def attack
      QuickEngagement.call(
        attacker: @attacker,
        defender: @defender
      )
    end

    def result
      RewardCalculator.call(
        attacker: @attacker,
        defender: @defender
      )
    end
  end
end
