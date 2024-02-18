class DarkWizard < Character
  has_one :character, as: :characterable
end
