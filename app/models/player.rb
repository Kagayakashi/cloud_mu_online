class Player < ApplicationRecord
  belongs_to :user
  belongs_to :character, class_name: "Characters::Character"

  validates :user_id, uniqueness: true, presence: true
  validates :character_id, uniqueness: true, presence: true
end
