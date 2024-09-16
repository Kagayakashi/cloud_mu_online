class MonsterPerformAttackJob
  include Sidekiq::Job

  def perform(monster_id, character_id)
    Monster.transaction do
      monster = Monster.lock("FOR UPDATE").find(monster_id)
      character = Character.lock("FOR UPDATE").find(character_id)

      if monster.target.nil?
        monster.update(target: character)
      end

      if character.map != monster.monster_type.map
        Rails.logger.info "Character's map does not match the monster's map."
        return
      end

      attack_service = MonsterAggroService.new(monster: monster, character: character)
      result = attack_service.call

      if result.target_killed
        Rails.logger.info "Monster #{monster.id} killed player"
      elsif result.damage_dealt > 0
        Rails.logger.info "Monster #{monster.id} deal #{result.damage_dealt} damage"
      else
        Rails.logger.info "Monster #{monster.id} cannot pass defense"
      end
    end
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "MonsterPerformAttackJob failed: #{e.message}"
  end
end
