class MonsterType < ApplicationRecord
  belongs_to :map
  has_many :monsters

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :level, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :health, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :min_attack, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :max_attack, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :attack_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :defense_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :defense, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :experience, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :spawn_time, presence: true, numericality: { greater_than_or_equal_to: 1 }

  validate :max_attack_greater_than_min_attack

  private

  def max_attack_greater_than_min_attack
    if max_attack.to_i < min_attack.to_i
      errors.add(:max_attack, "must be greater than or equal to min_attack")
    end
  end
end
