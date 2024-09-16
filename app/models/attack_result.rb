# Not active record. This is DTO
class AttackResult
  attr_reader :damage_dealt, :target_killed

  def initialize(damage_dealt:, target_killed:)
    @damage_dealt = damage_dealt
    @target_killed = target_killed
  end
end
