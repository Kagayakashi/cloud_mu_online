class Monster < ApplicationRecord
  belongs_to :monster_type
  has_one :target, :class_name => :character, :foreign_key => :target_id

  before_create :set_health

  private

  def set_health
    self.health = monster_type.health
  end
end
