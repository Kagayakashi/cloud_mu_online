module Characters
  class Monster < Character
    validates :location, presence: true

    before_create :calculate_params

    def attacks
      1
    end

    def has_wizardy?
      false
    end

    def calculate_attack_rate
      (agility * 1.5).floor
    end

    def calculate_min_attack
      strength
    end

    def calculate_max_attack
      strength * 2
    end

    def calculate_defense
      (agility / 5).floor
    end

    def calculate_defense_rate
      (agility / 5).floor
    end

    def calculate_health
      vitality * 5
    end

    def calculate_health_regen
      1
    end

    def calculate_mana
      energy * 10
    end

    def calculate_mana_regen
      1
    end

    def calculate_params
      self.attack_rate = calculate_attack_rate
      self.min_attack = calculate_min_attack
      self.max_attack = calculate_max_attack
      self.defense_rate = calculate_defense_rate
      self.defense = calculate_defense
      self.max_health = calculate_health
      self.max_mana = calculate_mana
      self.health = max_health
      self.mana = max_mana
    end
  end
end
