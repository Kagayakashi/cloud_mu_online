
class CharacterRegenerationService
  DELAY = 1.minute

  def self.call(character)
    instance = new(character)
    instance.regenerate
    instance
  end

  def initialize(character)
    @character = character
  end

  def regenerate
    return unless can_regenerate?

    ActiveRecord::Base.transaction do
      health_regen = @character.calculate_health_regen
      mana_regen = @character.calculate_mana_regen

      time_diff = Time.current.to_i - @character.last_regeneration_at.to_i
      regeneration_count = time_diff / DELAY

      total_health_regen = 0
      total_mana_regen = 0

      regeneration_count.times do
        actual_health_regen = [ health_regen, @character.max_health - @character.health ].min
        @character.health += actual_health_regen
        total_health_regen += actual_health_regen

        actual_mana_regen = [ mana_regen, @character.max_mana - @character.mana ].min
        @character.mana += actual_mana_regen
        total_mana_regen += actual_mana_regen

        break if @character.health == @character.max_health && @character.mana == @character.max_mana
      end

      @character.last_regeneration_at = Time.current

      if @character.save
        GameLogs::GameLog.create(
          character: @character,
          description: "You regenerated #{total_health_regen} health and #{total_mana_regen} mana."
        )
        @character
      else
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def can_regenerate?
    (@character.health < @character.max_health || @character.mana < @character.max_mana) &&
    (@character.last_regeneration_at.nil? || @character.last_regeneration_at < 1.minute.ago)
  end
end
