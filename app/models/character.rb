class Character < ApplicationRecord
  belongs_to :user
  belongs_to :map
  belongs_to :spot

  before_validation :set_default_values, if: :new_record?

  validates :name, presence: true, uniqueness: true
  validates :name, length: { minimum: 4, maximum: 20 }

  def add_experience_from_monster!(monster)
    experience = (monster.level.to_f / self.level * monster.experience).floor
    self.experience += experience
    add_level
    self.save
    experience
  end

  def max_experience
    (self.level * self.level) * (self.level + 9) * 2
  end

  private

  def add_level
    if self.experience >= max_experience
      self.experience = 0
      self.level += 1
      self.points += 5
    end
  end

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
    self.map_id = Map.first.id # Lorencia
    self.spot_id = Spot.first.id # Lorencia City
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
