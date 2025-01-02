module RewardsService
  class ExperienceGain
    attr_reader :experience, :leveled_up, :level

    def self.call(monster:, player_character:)
      instance = new(monster: monster, player_character: player_character)
      instance.apply
      instance
    end

    def initialize(monster:, player_character:)
      @monster_type = monster.monster_type
      @player_character = player_character
    end

    def apply
      @experience = calculate_experience
      @player_character.experience += @experience
      @player_character.gold += @experience
      level_up_if_can
      @player_character.save
    end

    private

    def calculate_experience
      (@monster_type.level.to_f / @player_character.level * @monster_type.experience).floor
    end

    def level_up_if_can
      @leveled_up = false
      while @player_character.experience >= @player_character.max_experience do
        level_up
        @leveled_up = true
      end

      update_stats
    end

    def level_up
      @player_character.level += 1
      @player_character.points += 5
      @player_character.experience -= @player_character.max_experience
      @player_character.max_experience = @player_character.calculate_max_experience

      @level = @player_character.level
    end

    def update_stats
      @player_character.max_health = @player_character.calculate_health
      @player_character.health = @player_character.max_health
      @player_character.max_mana = @player_character.calculate_mana
      @player_character.mana = @player_character.max_mana
    end
  end
end
