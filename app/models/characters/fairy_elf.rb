module Characters
  class FairyElf < Character
    def self.order
      3
    end

    def has_wizardy?
      false
    end

    def calculate_attack_rate
      (level * 5 + agility * 1.5 + energy / 4).floor
    end

    def calculate_min_attack
      (strength + agility * 2).floor / 14
    end

    def calculate_max_attack
      (strength + agility * 2).floor / 8
    end

    def calculate_min_wizard
      0
    end

    def calculate_max_wizard
      0
    end

    def calculate_defense
      (agility / 10).floor
    end

    def calculate_defense_rate
      (agility / 4).floor
    end

    def calculate_health
      40 + (level - 1) + vitality * 2
    end

    def calculate_health_regen
      1 + (vitality / 20).floor + (0.015 * max_health).floor
    end

    def calculate_mana
      (6 + (energy + level) * 1.5).floor
    end

    def calculate_mana_regen
      1 + (calculate_mana / 27.5).floor
    end

    private

    def set_default_stats!
      self.profession = Profession.find_by(code: "fe")
      self.strength = 22
      self.agility = 25
      self.vitality = 20
      self.energy = 15
      self.map = Map.find_by(code: "noria")
    end
  end
end
