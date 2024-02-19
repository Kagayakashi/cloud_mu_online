module CharacterTypes
  class DarkWizard < Character
    has_one :character, as: :characterable
  end
end
