module CombatService
  class Result
    attr_reader :hit_count, :total_damage, :defender_health

    def initialize(hit_count:, total_damage:, defender_health:)
      @hit_count = hit_count
      @total_damage = total_damage
      @defender_health = defender_health
    end
  end
end
