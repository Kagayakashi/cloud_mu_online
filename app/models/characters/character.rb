module Characters
  # Base class for all character types. Do not use directly.
  class Character < ApplicationRecord
    belongs_to :city

    validates :city, presence: true
    validates :name, presence: true, uniqueness: true, length: { in: 4..20 }

    def attacks
      1
    end

    def dead?
      health <= 0
    end
  end
end
