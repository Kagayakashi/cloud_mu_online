class Player < ApplicationRecord
  belongs_to :user
  belongs_to :character, class_name: "Characters::Character"

  validates :user, uniqueness: true
  validates :character, uniqueness: true
end
