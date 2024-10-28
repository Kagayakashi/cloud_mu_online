module Characters
  class DarkKnight < Character
    def self.order
      1
    end
    
    def has_wizardy?
      false
    end

    def set_default_stats!
      strength = 28
      agility = 20
      vitality = 25
      energy = 10
    end

    def calculate_attack_rate
      (level * 5 + agility * 1.5 + strength / 4).floor
    end

    def calculate_min_attack
      (strength / 6).floor
    end

    def calculate_max_attack
      (strength / 4).floor
    end

    def calculate_min_wizard
      0
    end

    def calculate_max_wizard
      0
    end

    def calculate_defense
      (agility / 3).floor
    end

    def calculate_defense_rate
      (agility / 3).floor
    end

    def calculate_health
      35 + (level - 1) + vitality * 3
    end

    def calculate_health_regen
      1 + (vitality / 20).floor + (0.015 * max_health).floor
    end

    def calculate_mana
      10 + (level - 1) / 2 + energy
    end

    def calculate_mana_regen
      1 + (calculate_mana / 27.5).floor
    end
  end
end
