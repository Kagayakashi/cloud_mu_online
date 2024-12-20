# Event subscriber to listen monster attack event
ActiveSupport::Notifications.subscribe("monster.perform_attack") do |name, start, finish, id, payload|
  monster = payload[:monster]
  character = payload[:character]

  Rails.logger.info "Event monster reaction: #{name} with monster #{monster.id} and character #{character.id}"

  MonsterPerformAttackJob.perform_later(monster.id, character.id)
end
