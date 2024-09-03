class SpotMonster < ApplicationRecord
  belongs_to :monster
  belongs_to :spot
  has_one :target, :class_name => :character, :foreign_key => :target_id

  before_create :set_health

  private

  def set_health
    self.health = self.monster.health
  end
end
