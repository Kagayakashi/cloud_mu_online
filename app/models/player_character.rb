class PlayerCharacter < ApplicationRecord
  belongs_to :user
  belongs_to :character

  validates :user_id, uniqueness: true
end
