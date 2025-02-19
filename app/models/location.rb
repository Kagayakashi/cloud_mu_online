class Location < ApplicationRecord
  belongs_to :map
  has_many :monsters, class_name: "Characters::Monster", dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }

  scope :peace, -> { where(peace: true) }
  scope :spots, -> { where(peace: false) }
end
