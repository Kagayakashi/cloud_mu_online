class MonsterPerformAttackJob < ApplicationJob
  def perform(monster_id, character_id)
    Monster.transaction do
      monster = Monster.lock("FOR UPDATE").find(monster_id)
      character = Characters::Character.lock("FOR UPDATE").find(character_id)

      if monster.target.nil?
        Rails.logger.info "Monster setting his target to #{character.name}"
        monster.update(target: character)
      end

      if character.map != monster.monster_type.map
        Rails.logger.info "Character's map does not match the monster's map."
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
