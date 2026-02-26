class Location < ApplicationRecord
  belongs_to :city

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :level, presence: true, numericality: { greater_than_or_equal_to: 1 }
end
