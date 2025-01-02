class Monster < ApplicationRecord
  belongs_to :monster_type
  belongs_to :target, class_name: "Characters::Character", foreign_key: :target_id, optional: true

  before_validation :set_health, if: :new_record?

  validates :monster_type_id, presence: true

  scope :alive, -> { where(dead: false) }
  scope :dead_for_respawn, -> { where(dead: true).where("dead_at <= ?", respawn_time.ago) }

  def self.respawn_time
    60.seconds
  end

  def name
    monster_type.name
  end

  def attack_rate
    monster_type.attack_rate
  end

  def min_attack
    monster_type.min_attack
  end

  def max_attack
    monster_type.max_attack
  end

  def defense_rate
    monster_type.defense_rate
  end

  def defense
    monster_type.defense
  end

  def attacks
    monster_type.attacks
  end

  def max_health
    monster_type.health
  end

  private

  def set_health
    if monster_type.present?
      self.health = monster_type.health
    end
  end
end
