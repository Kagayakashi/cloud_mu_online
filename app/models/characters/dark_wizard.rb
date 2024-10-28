module Characters
  class DarkWizard < Character
    def self.order
      2
    end

    def has_wizardy?
      true
    end

    def calculate_attack_rate
      (level * 5 + agility * 1.5 + energy / 4).floor
    end

    def calculate_min_attack
      (strength / 8).floor
    end

    def calculate_max_attack
      (strength / 6).floor
    end

    def calculate_min_wizard
      (energy / 9).floor
    end

    def calculate_max_wizard
      (energy / 4).floor
    end

    def calculate_defense
      (agility / 4).floor
    end

    def calculate_defense_rate
      (agility / 3).floor
    end

    def calculate_health
      30 + (level - 1) + vitality * 2
    end

    def calculate_health_regen
      1 + (vitality / 20).floor + (0.015 * max_health).floor
    end

    def calculate_mana
      (energy + level - 1) * 2
    end

    def calculate_mana_regen
      1 + (calculate_mana / 27.5).floor
    end

    private

    def set_default_stats!
      self.profession = Profession.find_by(code: "dw")
      self.strength = 18
      self.agility = 18
      self.vitality = 15
      self.energy = 30
    end
  end
end
