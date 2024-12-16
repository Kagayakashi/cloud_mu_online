module RewardsService
  class Distribution
    def self.call(monster:, player_character:)
      instance = new(monster: monster, player_character: player_character)
      instance.apply
    end

    def initialize(monster:, player_character:)
      @monster_type = monster.monster_type
      @player_character = player_character
    end

    def apply
      exp = calculate_experience
      @player_character.experience += exp
      @player_character.gold += exp
      @player_character.save!
    end

    private

    def calculate_experience
      (@monster_type.level.to_f / @player_character.level * @monster_type.experience).floor
    end
  end
end
