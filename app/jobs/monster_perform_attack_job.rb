class MonsterPerformAttackJob < ApplicationJob
  def perform(monster_id, character_id)
    Monster.transaction do
      return if monster.target.nil?

      monster = Monster.lock("FOR UPDATE").find(monster_id)
      character = Characters::Character.lock("FOR UPDATE").find(character_id)

      if character.map != monster.monster_type.map
        monster.update(target: nil)
        return
      end

      attack_service = MonsterAggroService.new(monster: monster, character: character)
      attack_service.call
    end
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "MonsterPerformAttackJob failed: #{e.message}"
  end
end
