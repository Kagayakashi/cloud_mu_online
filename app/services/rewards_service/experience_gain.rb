module RewardsService
  class ExperienceGain
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
      level_up_if_can
    end

    private

    def calculate_experience
      (@monster_type.level.to_f / @player_character.level * @monster_type.experience).floor
    end

    def level_up_if_can
      while @player_character.experience >= @player_character.max_experience do
        @player_character.level += 1
        @player_character.points += 5
        @player_character.experience -= @player_character.max_experience
        @player_character.max_experience = @player_character.calculate_max_experience
      end

      @player_character.max_health = @player_character.calculate_health
      @player_character.health = @player_character.max_health
      @player_character.max_mana = @player_character.calculate_mana
      @player_character.mana = @player_character.max_mana

      @player_character.level
    end
  end
end
