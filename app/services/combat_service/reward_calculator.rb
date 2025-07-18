module CombatService
  class RewardCalculator
    def self.call(attacker:, defender:)
      instance = new(attacker, defender)
      instance.apply
      instance
    end

    def initialize(attacker, defender)
      @attacker = attacker
      @defender = defender
    end

    def apply
      return unless @defender.dead?
      return if @attacker.dead?
      return unless @attacker.is_a?(Characters::Player)

      xp = 3
      gold = 3

      GameLogs::ExperienceGainedLog.create(
        character: @attacker,
        description: "You gained #{xp} experience."
      )
      GameLogs::LootReceivedLog.create(
        character: @attacker,
        description: "You received #{gold} gold."
      )

      @attacker.add_experience(xp)
      @attacker.add_gold(gold)
    end
  end
end
