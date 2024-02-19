module CharacterTypes
  class DarkKnight < Character
    has_one :character, as: :characterable
  end
end
