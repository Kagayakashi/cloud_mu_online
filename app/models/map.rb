class Map < ApplicationRecord
  has_many :spots
  has_many :characters
end
