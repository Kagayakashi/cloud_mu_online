module CombatService
  class DamageCalculation
    def initialize(min_attack:, max_attack:, defense:)
      @min_attack = min_attack
      @max_attack = max_attack
      @defense = defense
    end

    def damage
      damage = rand(@min_attack..@max_attack)
      damage -= @defense
      [ damage, 0 ].max
    end
  end
end
