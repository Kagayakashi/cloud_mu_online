class Spot < ApplicationRecord
  belongs_to :map
  has_many :characters
end
