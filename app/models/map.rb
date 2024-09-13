class Map < ApplicationRecord
  has_many :spots
  has_many :characters

  has_many :monster_types
  has_many :monsters, through: :monster_types

  has_many :map_connections
  has_many :connected_maps, through: :map_connections, source: :connected_map
end
