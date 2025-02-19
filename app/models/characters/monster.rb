module Characters
  class Monster < Character
    validates :location, presence: true

    def attacks
      2
    end
  end
end
