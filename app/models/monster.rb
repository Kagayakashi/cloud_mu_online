class Monster < ApplicationRecord
  belongs_to :monster_type
  belongs_to :target, class_name: "Characters::Character", foreign_key: :target_id, optional: true

  before_create :set_health

  private

  def set_health
    self.health = monster_type.health
  end
end
