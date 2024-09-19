class MonsterType < ApplicationRecord
  belongs_to :map
  has_many :monsters
end
