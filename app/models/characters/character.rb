module Characters
  # Base class for all character types. Do not use directly.
  class Character < ApplicationRecord
    attr_accessor :hp

    after_initialize :set_default_hp

    belongs_to :map
    belongs_to :location, optional: true

    validates :map, presence: true
    validates :name, presence: true, uniqueness: true, length: { in: 4..20 }

    def set_default_hp
      @hp ||= health
    end

    def attacks
      1
    end

    def profession
      type.split("::").last # Get last part (e.g., "DarkKnight")
          .underscore       # Convert "DarkKnight" -> "dark_knight"
          .humanize         # Convert "dark_knight" -> "Dark Knight"
    end
  end
end
