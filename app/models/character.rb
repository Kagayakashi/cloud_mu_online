class Character < ApplicationRecord
  belongs_to :user

  before_save :set_default_values, if: :new_record?

  validates :name, presence: true, uniqueness: true

  private

  def set_default_values
    self.level = 1
    self.experience = 0
    self.points = 0
    self.active = false

    character_type.set_default_stats!(self)

    self.max_health = character_type.calculate_health(self)
    self.current_health ||= self.max_health

    self.max_mana = character_type.calculate_mana(self)
    self.current_mana ||= self.max_mana
  end

  def character_type
    case self.profession.to_sym
    when :dark_wizard then CharacterTypes::DarkWizard
    when :dark_knight then CharacterTypes::DarkKnight
    when :elf then CharacterTypes::Elf
    else
      nil
    end
  end
end
