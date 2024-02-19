module CharacterTypes
  class LightElf < Character
    has_one :character, as: :characterable
  end
end
