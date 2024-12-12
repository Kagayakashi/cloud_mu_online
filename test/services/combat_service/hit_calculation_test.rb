require "test_helper"

class CombatService::HitCalculationTest < ActiveSupport::TestCase
  test "should calculate hit chance to be 0.25" do
    accuracy = CombatService::HitCalculation.new(attack_rate: 100, defense_rate: 75, )
    assert_equal 0.25, accuracy.hit_chance
  end

  test "should calculate hit chance to be 0.5" do
    accuracy = CombatService::HitCalculation.new(attack_rate: 10, defense_rate: 5, )
    assert_equal 0.5, accuracy.hit_chance
  end

  test "should calculate hit chance to be 0.75" do
    accuracy = CombatService::HitCalculation.new(attack_rate: 100, defense_rate: 25, )
    assert_equal 0.75, accuracy.hit_chance
  end

  test "should calculate hit chance to be 0.03 with high defense rate" do
    accuracy = CombatService::HitCalculation.new(attack_rate: 1, defense_rate: 10, )
    assert_equal 0.03, accuracy.hit_chance
  end

  test "should calculate hit chance to be 1 with high attack rate" do
    accuracy = CombatService::HitCalculation.new(attack_rate: 10, defense_rate: 0, )
    assert_equal 1.0, accuracy.hit_chance
  end
end
