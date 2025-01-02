module RewardsService
  class Distribution
    def self.call(monster:, player_character:)
      instance = new(monster: monster, player_character: player_character)
      instance.apply
    end

    def initialize(monster:, player_character:)
      @monster = monster
      @player_character = player_character
    end

    def apply
      ExperienceGain.call(monster: @monster, player_character: @player_character)
    end
  end
end
