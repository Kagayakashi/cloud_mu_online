class Profession < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :max_level, presence: true, numericality: { greater_than_or_equal_to: 1 }
end
