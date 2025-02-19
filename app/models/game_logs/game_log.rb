module GameLogs
  class GameLog < ApplicationRecord
    belongs_to :character, class_name: "Characters::Player"
    validates :character_id, :description, presence: true
  end
end
