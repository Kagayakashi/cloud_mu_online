class Map < ApplicationRecord
  has_many :characters
  has_many :map_connections

  scope :teleportable, -> { where(can_teleport: true) }

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :min_level, presence: true, numericality: { greater_than_or_equal_to: 1 }
end
