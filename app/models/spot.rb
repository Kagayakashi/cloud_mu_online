class Spot < ApplicationRecord
  belongs_to :map
  has_many :characters
  has_many :spot_monsters
end
