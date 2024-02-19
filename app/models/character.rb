class Character < ApplicationRecord
  belongs_to :user
  belongs_to :characterable, polymorphic: true

  validates :name, presence: true, uniqueness: true
end
