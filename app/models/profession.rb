class Profession < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  validates :level, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
