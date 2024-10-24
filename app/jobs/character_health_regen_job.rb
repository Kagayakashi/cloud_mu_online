class CharacterHealthRegenJob
  def perform(character_id)
    Monster.transaction do
      character = Character.lock("FOR UPDATE").find(character_id)
      current_health = character.current_health + character.character_type.calculate_health_regen(character)

      current_health = character.max_health if current_health > character.max_health

      character.update(current_health: current_health)

      return if character.current_health == character.max_health

      CharacterHealthRegenJob.perform_in(1.minutes, character_id)
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error "CharacterHealthRegenJob failed: #{e.message}"
    end
  end
end
