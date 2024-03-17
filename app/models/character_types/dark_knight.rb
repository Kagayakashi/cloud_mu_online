module CharacterTypes
  class DarkKnight
    def self.set_default_stats!(character)
      character.strength = 28
      character.agility = 20
      character.vitality = 25
      character.energy = 10
      character
    end

    def self.calculate_attack_rate(character)
      (character.level * 5 + character.agility * 1.5 + character.strength / 4).floor
    end

    def self.calculate_min_attack(character)
      (character.strength / 6).floor
    end

    def self.calculate_max_attack(character)
      (character.strength / 4).floor
    end

    def self.calculate_min_wizard(character)
      0
    end

    def self.calculate_max_wizard(character)
      0
    end

    def self.calculate_defense(character)
      (character.agility / 3).floor
    end

    def self.calculate_defense_rate(character)
      (character.agility / 3).floor
    end

    def self.calculate_health(character)
      35 + (character.level - 1) + character.vitality * 3
    end

    def self.calculate_mana(character)
      10 + (character.level - 1) / 2 + character.energy
    end

    def self.calculate_mana_regen(character)
      1 + (calculate_mana(character) / 27.5).floor
    end
  end
end
