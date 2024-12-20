class MonsterPerformAttackJob < ApplicationJob
  RETRY_DELAY = 10.seconds.freeze

  def perform(monster_id, character_id)
    ActiveRecord::Base.transaction do
      monster = Monster.lock("FOR UPDATE").find(monster_id)
      return if monster.target.nil?

      character = Characters::Character.lock("FOR UPDATE").find(character_id)

      if character.map != monster.monster_type.map
        monster.update(target: nil, health: monster.monster_type.health)
        return
      end

      combat = CombatService::Engagement.call(attacker: monster, defender: character, session: {})

      if combat.defender_health <= 0
        monster.update(target: nil)
        character.update(health: 1, map: Map.first)
        GameLogs::DamageReceivedLog.create(
          character: character,
          description: "#{monster.monster_type.name} killed you."
        )
      else
        MonsterPerformAttackJob.set(wait: RETRY_DELAY).perform_later(monster.id, character.id)
        GameLogs::DamageReceivedLog.create(
          character: character,
          description: "#{monster.monster_type.name} dealt #{combat.total_damage} damage to you."
        ) if combat.total_damage > 0
      end
    end
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error("[MonsterPerformAttackJob] Error: #{e.class} - #{e.message}. Monster ID: #{monster_id}, Character ID: #{character_id}. Trace: #{e.backtrace.take(5).join(' | ')}")
  end
end
