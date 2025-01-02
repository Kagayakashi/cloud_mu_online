module CombatService
  class MonsterDeath
    def self.call(monster)
      instance = new(monster)
      instance.handle
      instance
    end

    def initialize(monster)
      raise ArgumentError, "monster must be a Monster" unless monster.is_a?(Monster)
      @monster = monster
    end

    def handle
      if @monster.health <= 0
        @monster.update(target: nil, dead: true, dead_at: Time.now, health: @monster.max_health)
      end
    end
  end
end
