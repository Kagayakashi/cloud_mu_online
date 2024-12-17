class Monster < ApplicationRecord
  belongs_to :monster_type
  belongs_to :target, class_name: "Characters::Character", foreign_key: :target_id, optional: true

  before_validation :set_health, if: :new_record?

  private

  def set_health
    if monster_type.present?
      self.health = monster_type.health
    end
  end
end
