class Player < ApplicationRecord
  belongs_to :user
  belongs_to :character

  validates :user, uniqueness: true
  validates :character, uniqueness: true
end
