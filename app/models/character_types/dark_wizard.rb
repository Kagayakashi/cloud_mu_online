module CharacterTypes
  class DarkWizard
    def self.has_wizardy?
      true
    end

    def self.set_default_stats!(character)
      character.strength = 18
      character.agility = 18
      character.vitality = 15
      character.energy = 30
      character
    end

    def self.calculate_attack_rate(character)
      (character.level * 5 + character.agility * 1.5 + character.energy / 4).floor
    end

    def self.calculate_min_attack(character)
      (character.strength / 8).floor
    end

    def self.calculate_max_attack(character)
      (character.strength / 6).floor
    end

    def self.calculate_min_wizard(character)
      (character.energy / 9).floor
    end

    def self.calculate_max_wizard(character)
      (character.energy / 4).floor
    end

    def self.calculate_defense(character)
      (character.agility / 4).floor
    end

    def self.calculate_defense_rate(character)
      (character.agility / 3).floor
    end

    def self.calculate_health(character)
      30 + (character.level - 1) + character.vitality * 2
    end

    def self.calculate_health_regen(character)
      1 + (character.vitality / 20).floor + (0.015 * character.max_health).floor
    end

    def self.calculate_mana(character)
      (character.energy + character.level - 1) * 2
    end

    def self.calculate_mana_regen(character)
      1 + (calculate_mana(character) / 27.5).floor
    end
  end
end
