# Not active record. This is DTO
class AttackMonsterResult
  attr_reader :damage_dealt, :monster_killed

  def initialize(damage_dealt:, monster_killed:)
    @damage_dealt = damage_dealt
    @monster_killed = monster_killed
  end
end
