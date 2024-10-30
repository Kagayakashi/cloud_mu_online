require "test_helper"

class CharacterTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should have character types as subclasses" do
    assert_includes Characters::Character.subclasses.map(&:name), "Characters::DarkKnight"
    assert_includes Characters::Character.subclasses.map(&:name), "Characters::DarkWizard"
    assert_includes Characters::Character.subclasses.map(&:name), "Characters::Elf"
  end

  test "should have character types as human-readable names" do
    character_types = Characters::Character.character_types
    assert_includes character_types.map(&:first), "Dark Knight"
    assert_includes character_types.map(&:first), "Dark Wizard"
    assert_includes character_types.map(&:first), "Elf"
  end

  test "should create a dark knight with a name" do
    character = Characters::DarkKnight.new(name: "CreatedDarkKnight1", type: "Characters::DarkKnight", user: @user)

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

  test "should create a dark knight with a character creator service" do
    service = CharacterCreatorService.new(user: @user, name: "CreatedDarkKnight2", type: "Characters::DarkKnight")
    character = service.call

    assert_not_nil = character

    assert_equal "CreatedDarkKnight2", character.name
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

  teardown do
    Characters::Character.delete_all  # Удаляем всех персонажей после тестов
  end
end
