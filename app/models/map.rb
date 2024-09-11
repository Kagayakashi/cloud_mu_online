class Map < ApplicationRecord
  has_many :spots
  has_many :characters
  # Todo associate with map to travel btw maps
end
