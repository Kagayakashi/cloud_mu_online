require "test_helper"
require 'ostruct'

class CombatService::PerformAttackTest < ActiveSupport::TestCase
  def setup
    @attacker = OpenStruct.new(
      attack_rate: 75,
      min_attack: 25,
      max_attack: 50,
      attacks: 10
    )

    @defender = OpenStruct.new(
      defense_rate: 50,
      defense: 25,
      current_health: 1000
    )
  end

  test "should calculate total damage and hit count" do
    result = CombatService::PerformAttack.call(attacker: @attacker, defender: @defender)
    assert_includes 0..@attacker.attacks, result.hit_count
    assert_operator result.total_damage, :>=, 0
    assert_operator result.defender_health, :>=, 0
  end

  test "should not allow negative health" do
    @attacker.min_attack = 9999
    @attacker.max_attack = 9999
    @attacker.attack_rate = 9999
    result = CombatService::PerformAttack.call(attacker: @attacker, defender: @defender)
    assert_equal 0, result.defender_health
  end

  test "should calculate damage properly with not enough attack" do
    @attacker.min_attack = 15
    @attacker.max_attack = 25
    result = CombatService::PerformAttack.call(attacker: @attacker, defender: @defender)
    assert_equal 0, result.total_damage
  end
end
