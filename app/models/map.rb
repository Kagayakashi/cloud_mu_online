class Map < ApplicationRecord
  has_many :players, class_name: "Characters::Player", dependent: :destroy
  has_many :monsters, class_name: "Characters::Monster", dependent: :destroy

  has_many :locations

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :level, presence: true, numericality: { greater_than_or_equal_to: 1 }
end
