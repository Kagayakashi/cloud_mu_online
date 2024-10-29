module GameLogs
  class GameLog < ApplicationRecord
    belongs_to :character, class_name: "Characters::Character"
  end
end
