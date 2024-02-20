module CharacterTypes
  class DarkWizard
    def self.set_default_stats!(character)
      character.strength = 18
      character.agility = 18
      character.vitality = 15
      character.energy = 30
      character
    end

    def self.calculate_health(character)
      30 + (character.level - 1) + character.vitality * 2
    end

    def self.calculate_mana(character)
      (character.energy + character.level - 1) * 2
    end
  end
end
