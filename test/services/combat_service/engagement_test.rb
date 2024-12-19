require "test_helper"
require "ostruct"

class CombatService::EngagementTest < ActiveSupport::TestCase
  def setup
    @attacker = characters_characters(:one)
    @defender = monsters(:one)
    @session = {}
  end

  test "should calculate total hit count" do
    @defender.health = 100
    combat = CombatService::Engagement.new(attacker: @attacker, defender: @defender, session: @session)

    assert_equal 100, combat.defender_health

    3.times do
      combat.attack
    end

    assert_operator combat.defender_health, :>, 1
    assert_operator combat.hit_count, :>, 1
    assert_operator combat.defender_health, :<, 100
  end

  test "should calculate total damage and hit count" do
    combat = CombatService::Engagement.call(attacker: @attacker, defender: @defender, session: @session)
    assert_includes 1..@attacker.attacks, combat.hit_count
    assert_operator combat.total_damage, :>=, 1
    assert_operator combat.defender_health, :>=, 0
  end

  test "should not allow negative health" do
    @attacker.min_attack = 9999
    @attacker.max_attack = 9999
    @attacker.attack_rate = 9999
    combat = CombatService::Engagement.call(attacker: @attacker, defender: @defender, session: @session)
    assert_equal 0, combat.defender_health
  end

  test "should calculate damage properly with not enough attack" do
    @attacker.min_attack = 1
    @attacker.max_attack = 1
    combat = CombatService::Engagement.call(attacker: @attacker, defender: @defender, session: @session)
    assert_equal 0, combat.total_damage
  end
end
