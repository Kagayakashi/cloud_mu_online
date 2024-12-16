require "test_helper"

module Characters
  class DarkWizardTest < ActiveSupport::TestCase
    setup do
      @user = users(:one)
    end

    test "should be valid dark wizard" do
      character = Characters::DarkWizard.new(name: "Test Wizard", user: @user)
      assert character.valid?
    end

    test "should save a valid dark wizard" do
      character = Characters::DarkWizard.new(name: "Test Wizard", user: @user)
      assert character.save
    end

    test "should not be valid character with existing name" do
      character = Characters::DarkWizard.new(name: "DarkWizard", user: @user)
      assert character.save
      character = Characters::DarkWizard.new(name: "DarkWizard", user: @user)
      assert_not character.valid?
    end

    test "should create a dark wizard with right attributes" do
      character = Characters::DarkWizard.new(name: "CreatedDarkWizard1", user: @user)

      assert character.save!

      assert_equal "CreatedDarkWizard1", character.name
      assert_equal "Characters::DarkWizard", character.type

      assert_equal 1, character.level
      assert_equal 0, character.experience
      assert_equal 0, character.points

      assert_equal 18, character.strength
      assert_equal 18, character.agility
      assert_equal 15, character.vitality
      assert_equal 30, character.energy

      assert_equal 39, character.calculate_attack_rate
      assert_equal 3, character.calculate_min_attack
      assert_equal 7, character.calculate_max_attack
      assert_equal 6, character.calculate_defense_rate
      assert_equal 4, character.calculate_defense
      assert_equal 60, character.calculate_health
      assert_equal 60, character.calculate_mana
      assert_equal 1, character.calculate_health_regen
      assert_equal 3, character.calculate_mana_regen

      assert_equal 60, character.current_health
      assert_equal 60, character.current_mana
      assert_equal 60, character.max_health
      assert_equal 60, character.max_mana

      assert_equal 0, character.gold
      assert_equal 100, character.activity
      assert_equal "Lorencia city", character.map.name

      assert_not_nil character.last_restore_at
      assert_not_nil character.last_regeneration_at
    end
  end
end
