module GameLogs
  class GameLog < ApplicationRecord
    belongs_to :character
  end
end
