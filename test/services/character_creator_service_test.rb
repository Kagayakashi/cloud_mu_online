require "test_helper"

class CharacterCreatorServiceTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test "should successfully create a dark knight" do
    service = CharacterCreatorService.new(
      user: @user,
      name: "CharacterCreatorServiceDK1",
      type: "Characters::DarkKnight"
    )
    character = service.call

    assert character.persisted?, "Character should be persisted in the database"
    assert_equal "CharacterCreatorServiceDK1", character.name
    assert_equal "Characters::DarkKnight", character.type
  end

  test "should not be persisted when type is invalid" do
    service = CharacterCreatorService.new(user: @user, name: "InvalidTypeCharacter", type: "Characters::InvalidType")
    character = service.call
    assert_not character.persisted?
  end

  test "should not be persisted when name is blank" do
    service = CharacterCreatorService.new(user: @user, name: "", type: "Characters::DarkKnight")
    character = service.call
    assert_not character.persisted?
  end

  test "created dark knight should have calculated stats" do
    service = CharacterCreatorService.new(user: @user, name: "CreatedDarkKnight2", type: "Characters::DarkKnight")
    character = service.call

    assert_not_nil character

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

    assert_equal 110, character.health
    assert_equal 20, character.mana
    assert_equal 110, character.max_health
    assert_equal 20, character.max_mana

    assert_equal 0, character.gold
    assert_equal 100, character.activity
    assert_equal "Lorencia city", character.map.name

    assert_not_nil character.last_restore_at
    assert_not_nil character.last_regeneration_at
  end
end
