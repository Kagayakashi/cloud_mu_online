module CombatService
  class HitCalculation
    attr_reader :hit_chance

    def initialize(attack_rate:, defense_rate:)
      @hit_chance = calculate_accuracy(attack_rate, defense_rate)
    end

    def hit?
      threshold = rand(0.01..1.00).round(2)
      hit_chance >= threshold
    end

    private

    def calculate_accuracy(attack_rate, defense_rate)
      return 1.00 if defense_rate <= 0

      if defense_rate < attack_rate
        (1.00 - (defense_rate.to_f / attack_rate)).round(2)
      else
        0.03
      end
    end
  end
end
