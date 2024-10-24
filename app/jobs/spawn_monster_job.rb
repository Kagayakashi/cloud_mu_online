class SpawnMonsterJob < ApplicationJob
  def perform(monster_type_id)
    monster_type = MonsterType.find(monster_type_id)
    monster_type.monsters.create
  end
end
