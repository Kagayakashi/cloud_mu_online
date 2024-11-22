require "test_helper"
require 'ostruct'

class CombatService::EngagementTest < ActiveSupport::TestCase
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

  test "should calculate total hit count to kill defender" do
    @defender.current_health = 150
    combat = CombatService::Engagement.new(attacker: @attacker, defender: @defender)

    assert_equal 150, combat.defender_health

    10.times do
      break if combat.defender_health.zero?
      combat.attack
    end

    assert_operator combat.total_damage, :>=, 1
    assert_operator combat.hit_count, :>=, 1
    assert_equal 0, combat.defender_health
  end

  test "should calculate total damage and hit count" do
    combat = CombatService::Engagement.call(attacker: @attacker, defender: @defender)
    assert_includes 1..@attacker.attacks, combat.hit_count
    assert_operator combat.total_damage, :>=, 1
    assert_operator combat.defender_health, :>=, 0
  end

  test "should not allow negative health" do
    @attacker.min_attack = 9999
    @attacker.max_attack = 9999
    @attacker.attack_rate = 9999
    combat = CombatService::Engagement.call(attacker: @attacker, defender: @defender)
    assert_equal 0, combat.defender_health
  end

  test "should calculate damage properly with not enough attack" do
    @attacker.min_attack = 15
    @attacker.max_attack = 25
    combat = CombatService::Engagement.call(attacker: @attacker, defender: @defender)
    assert_equal 0, combat.total_damage
  end
end
