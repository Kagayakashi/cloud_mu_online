class Map < ApplicationRecord
  has_many :spots
  has_many :characters

  has_many :monster_types
  has_many :monsters, through: :monster_types

  has_many :map_connections
  has_many :connected_maps, through: :map_connections, source: :connected_map

  scope :teleportable, -> { where(can_teleport: true) }

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :min_level, :teleport_min_level, :teleport_cost, presence: true, numericality: { greater_than_or_equal_to: 1 }
end
