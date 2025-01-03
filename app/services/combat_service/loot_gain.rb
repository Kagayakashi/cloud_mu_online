module CombatService
  class LootGain
    def self.call(monster:, player_character:)
      instance = new(monster: monster, player_character: player_character)
      instance.apply
      instance
    end

    def initialize(monster:, player_character:)
      raise ArgumentError, "monster must be a Monster" unless monster.is_a?(Monster)
      raise ArgumentError, "player_character must be a Character" unless player_character.is_a?(Characters::Character)
      @monster_type = monster.monster_type
      @player_character = player_character
    end

    def apply
      gold = calculate_gold
      @player_character.gold += gold
      GameLogs::LootReceivedLog.create(character: @player_character, description: "You received #{gold} gold.")
    end

    private

    def calculate_gold
      (@monster_type.level.to_f / @player_character.level * @monster_type.experience).floor
    end
  end
end
