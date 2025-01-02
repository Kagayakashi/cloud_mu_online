module RewardsService
  def self.call(monster:, character:)
    validate_inputs(monster, character)

    rewards = Distribution.call(monster: monster, player_character: character)
    log_rewards(rewards, character)
  end

  private

  def self.validate_inputs(monster, character)
    raise ArgumentError, "monster must be a Monster" unless monster.is_a?(Monster)
    raise ArgumentError, "character must be a Character" unless character.is_a?(Characters::Character)
  end

  def self.log_rewards(rewards, character)
    log_experience(rewards.experience, character) if rewards.experience
    log_level(rewards.level, character) if rewards.level
  end

  def self.log_experience(experience, character)
    GameLogs::ExperienceGainedLog.create(
      character: character,
      description: "You received #{experience} experience."
    )
  end

  def self.log_level(level, character)
    GameLogs::ExperienceGainedLog.create(
      character: character,
      description: "You leveled up to level #{level}."
    )
  end
end
