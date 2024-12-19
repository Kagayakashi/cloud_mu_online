# Event subscriber to listen monster attack event
ActiveSupport::Notifications.subscribe('monster.perform_attack') do |name, start, finish, id, payload|
  monster = payload[:monster]
  character = payload[:character]

  MonsterPerformAttackJob.perform_later(monster.id, character.id)
end
