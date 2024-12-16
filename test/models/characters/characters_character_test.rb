require "test_helper"

module Characters
  class CharacterTest < ActiveSupport::TestCase
    setup do
      @user = users(:one)
    end

    test "should have character types as subclasses" do
      assert_includes Characters::Character.subclasses.map(&:name), "Characters::DarkKnight"
      assert_includes Characters::Character.subclasses.map(&:name), "Characters::DarkWizard"
      assert_includes Characters::Character.subclasses.map(&:name), "Characters::FairyElf"
    end

    test "should have character types as human-readable names" do
      character_types = Characters::Character.character_types
      assert_includes character_types.map(&:first), "Dark Knight"
      assert_includes character_types.map(&:first), "Dark Wizard"
      assert_includes character_types.map(&:first), "Fairy Elf"
    end

    test "should be valid character" do
      character = Characters::Character.new(name: "Test Warrior", type: "Characters::DarkKnight", user: @user)
      assert character.valid?
    end

    test "should save a valid character" do
      character = Characters::Character.new(name: "Test Warrior", type: "Characters::DarkKnight", user: @user)
      assert character.save
    end

    test "should not be valid character with existing name" do
      character = Characters::Character.new(name: "DarkKnight", type: "Characters::DarkKnight", user: @user)
      assert_not character.valid?
    end

    test "should create a character with right stats" do
      character = Characters::Character.new(name: "CreatedDarkKnight1", type: "Characters::DarkKnight", user: @user)

      assert character.save!

      assert_equal "CreatedDarkKnight1", character.name
      assert_equal "Characters::DarkKnight", character.type

      assert_equal 1, character.level
      assert_equal 0, character.experience
      assert_equal 0, character.points

      assert_equal 28, character.strength
      assert_equal 20, character.agility
      assert_equal 25, character.vitality
      assert_equal 10, character.energy

      assert_equal 42, character.calculate_attack_rate
      assert_equal 4, character.calculate_min_attack
      assert_equal 7, character.calculate_max_attack
      assert_equal 6, character.calculate_defense_rate
      assert_equal 6, character.calculate_defense
      assert_equal 110, character.calculate_health
      assert_equal 20, character.calculate_mana
      assert_equal 3, character.calculate_health_regen
      assert_equal 1, character.calculate_mana_regen

      assert_equal 110, character.current_health
      assert_equal 20, character.current_mana
      assert_equal 110, character.max_health
      assert_equal 20, character.max_mana

      assert_equal 0, character.gold
      assert_equal 100, character.activity
      assert_equal "Lorencia city", character.map.name

      assert_not_nil character.last_restore_at
      assert_not_nil character.last_regeneration_at
    end

    test "should have not enough exp to level up" do
      character = Characters::Character.new(name: "Test Warrior", type: "Characters::DarkKnight", user: @user)
      character.valid?

      character.experience = 19
      character.add_level
      assert_equal 1, character.level
    end

    test "should have enough exp to level up" do
      character = Characters::Character.new(name: "Test Warrior", type: "Characters::DarkKnight", user: @user)
      character.valid?

      character.experience = 20
      character.add_level
      assert_equal 2, character.level
    end

    test "should level up multiple times from a lot exp" do
      character = Characters::Character.new(name: "Test Warrior", type: "Characters::DarkKnight", user: @user)
      character.valid?

      character.experience = 1000
      character.add_level
      assert_operator character.level, :>, 3
    end

    test "should regenerate after time delay" do
      character = Characters::Character.new(name: "Test Warrior", type: "Characters::DarkKnight", user: @user)
      character.valid?

      initial_health = 1
      initial_mana = 1
      character.current_health = initial_health
      character.current_mana = initial_mana
      character.last_regeneration_at = 1.hour.ago.in_time_zone('UTC')

      character.regenerate
      assert_operator character.current_health, :>, initial_health
      assert_operator character.current_mana, :>, initial_mana
    end

    test "should not regenerate too often" do
      character = Characters::Character.new(name: "Test Warrior", type: "Characters::DarkKnight", user: @user)
      character.valid?

      initial_health = 1
      initial_mana = 1
      character.current_health = initial_health
      character.current_mana = initial_mana
      character.last_regeneration_at = 1.seconds.ago.in_time_zone('UTC')

      character.regenerate
      assert_equal character.current_health, initial_health
      assert_equal character.current_mana, initial_mana
    end
  end
end
