require "test_helper"

class CombatService::DamageCalculationTest < ActiveSupport::TestCase
  test "should calculate damage to be always 5" do
    damage = CombatService::DamageCalculation.new(min_attack: 10, max_attack: 10, defense: 5)
    assert_equal 5, damage.damage
  end

  test "should calculate damage from 0 to 5" do
    damage = CombatService::DamageCalculation.new(min_attack: 5, max_attack: 10, defense: 5)
    assert_includes 0..5, damage.damage
  end
end
