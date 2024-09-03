module CharacterTypes
  class Elf
    def self.set_default_stats!(character)
      character.strength = 22
      character.agility = 25
      character.vitality = 20
      character.energy = 15
      character
    end

    def self.calculate_attack_rate(character)
      (character.level * 5 + character.agility * 1.5 + character.energy / 4).floor
    end

    def self.calculate_min_attack(character)
      (character.strength + character.agility * 2).floor / 14
    end

    def self.calculate_max_attack(character)
      (character.strength + character.agility * 2).floor / 8
    end

    def self.calculate_min_wizard(character)
      0
    end

    def self.calculate_max_wizard(character)
      0
    end

    def self.calculate_defense(character)
      (character.agility / 10).floor
    end

    def self.calculate_defense_rate(character)
      (character.agility / 4).floor
    end

    def self.calculate_health(character)
      40 + (character.level - 1) + character.vitality * 2
    end

    def self.calculate_mana(character)
      (6 + (character.energy + character.level) * 1.5).floor
    end

    def self.calculate_mana_regen(character)
      1 + (calculate_mana(character) / 27.5).floor
    end
  end
end
