class Character < ApplicationRecord
  TYPES = {
    'warrior' => DarkKnight,
    'mage' => DarkWizard
  }.freeze

  belongs_to :user
  belongs_to :characterable, polymorphic: true

  validates :name, presence: true, uniqueness: true
end
