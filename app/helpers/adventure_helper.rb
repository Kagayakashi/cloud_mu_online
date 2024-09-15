module AdventureHelper
  def monster_health_percent(monster)
    health = 0
    if monster.health > 0
      health = monster.health.to_f / monster.monster_type.health.to_f * 100
    end

    health.floor
  end
end
