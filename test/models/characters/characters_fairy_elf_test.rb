require "test_helper"

module Characters
  class FairyElfTest < ActiveSupport::TestCase
    setup do
      @user = users(:one)
      @lorencia = maps(:lorencia)
    end

    test "should be valid character" do
      character = Characters::FairyElf.new(name: "Test Elf", user: @user)
      assert character.valid?
    end

    test "should save a valid character" do
      character = Characters::FairyElf.new(name: "Test Elf", user: @user)
      assert character.save
    end

    test "should not be valid character with existing name" do
      character = Characters::FairyElf.new(name: "FairyElf", user: @user)
      assert character.save
      character = Characters::FairyElf.new(name: "FairyElf", user: @user)
      assert_not character.valid?
    end

    test "should create a character with right attributes" do
      character = Characters::FairyElf.new(name: "CreatedFairyElf1", user: @user)

      assert character.save!

      assert_equal "CreatedFairyElf1", character.name
      assert_equal "Characters::FairyElf", character.type

      assert_equal 1, character.level
      assert_equal 0, character.experience
      assert_equal 0, character.points

      assert_equal 22, character.strength
      assert_equal 25, character.agility
      assert_equal 20, character.vitality
      assert_equal 15, character.energy

      assert_equal 45, character.calculate_attack_rate
      assert_equal 5, character.calculate_min_attack
      assert_equal 9, character.calculate_max_attack
      assert_equal 6, character.calculate_defense_rate
      assert_equal 2, character.calculate_defense
      assert_equal 80, character.calculate_health
      assert_equal 30, character.calculate_mana
      assert_equal 3, character.calculate_health_regen
      assert_equal 2, character.calculate_mana_regen

      assert_equal 80, character.health
      assert_equal 30, character.mana
      assert_equal 80, character.max_health
      assert_equal 30, character.max_mana

      assert_equal 0, character.gold
      assert_equal 10, character.activity
      assert_equal @lorencia.name, character.map.name

      assert_not_nil character.last_restore_at
      assert_not_nil character.last_regeneration_at
    end
  end
end
