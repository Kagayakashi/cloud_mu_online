class Character < ApplicationRecord
  belongs_to :user
  belongs_to :profession
  belongs_to :map

  before_create :set_default_values

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

  def set_attack_delay
    $redis.set("character:#{self.id}:last_time_attack", Time.now.to_f.round(1) + 3.0)
  end

  def attack_delay_left
    return 0 if can_attack?
    last_time_attack - Time.now.to_f
  end

  def can_attack?
    return true if last_time_attack.nil?
    last_time_attack < Time.now.to_f
  end

  def add_level
    if experience >= max_experience
      self.experience = 0
      self.level += 1
      self.points += 5
    end
  end

  def set_default_values
    self.level = 0
    self.experience = 0
    self.points = 0

    character_type.set_default_stats!(self)

    self.max_health = character_type.calculate_health(self)
    self.current_health ||= max_health

    self.max_mana = character_type.calculate_mana(self)
    self.current_mana ||= max_mana
    self.map = Map.first # Lorencia
    #self.spot = Spot.first # Lorencia City
  end

  def last_time_attack
    $redis.get("character:#{self.id}:last_time_attack").to_f
  end

  def character_type
    case self.profession.code.to_sym
    when :dw then CharacterTypes::DarkWizard
    when :dk then CharacterTypes::DarkKnight
    when :elf then CharacterTypes::Elf
    else
      nil
    end
  end
end
