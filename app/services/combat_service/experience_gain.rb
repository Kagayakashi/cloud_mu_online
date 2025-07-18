module CombatService
  class ExperienceGain
    def self.call(monster:, player_character:)
      instance = new(monster: monster, player_character: player_character)
      instance.apply
      instance
    end

    def initialize(monster:, player_character:)
      raise ArgumentError, "monster must be a Monster" unless monster.is_a?(Characters::Monster)
      raise ArgumentError,
        "player_character must be a Character" unless player_character.is_a?(Characters::Player)
      @monster = monster
      @player_character = player_character
    end

    def apply
      experience = calculate_experience
      GameLogs::ExperienceGainedLog.create(character: @player_character,
        description: "You received #{experience} experience.")
      @player_character.experience += experience
      level_up_if_can
    end

    private

    def calculate_experience
      level_diff = @monster.level - @player_character.level
      exp = 1
      if level_diff > 3
        level_diff = 3
      elsif level_diff < 1
        level_diff = 0
      end
      exp + level_diff
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

      GameLogs::ExperienceGainedLog.create(character: @player_character,
        description: "You leveled up to #{@player_character.level}!")

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
