require "test_helper"

class CharacterRegenerationServiceTest < ActiveSupport::TestCase
  def setup
    # low health and mana
    @character = characters_players(:low_status)
  end

  test "should regenerate health and mana once" do
    @character.update(last_regeneration_at: 90.seconds.ago)

    assert @character.health < @character.max_health
    assert @character.mana < @character.max_mana

    initial_health = @character.health
    initial_mana = @character.mana
    health_regen = @character.calculate_health_regen
    mana_regen = @character.calculate_mana_regen
    expected_health = initial_health + health_regen
    expected_mana = initial_mana + mana_regen

    CharacterRegenerationService.call(@character)

    assert_equal expected_health, @character.health
    assert_equal expected_mana, @character.mana
  end

  test "should not regenerate with full current health" do
    @character.update(health: @character.max_health, mana: @character.max_mana)

    CharacterRegenerationService.call(@character)

    assert_equal @character.max_health, @character.health
    assert_equal @character.max_mana, @character.mana
  end

  test "should not regenerate with last regeneration time 30 seconds" do
    @character.update(last_regeneration_at: 30.seconds.ago)

    initial_health = @character.health
    initial_mana = @character.mana

    CharacterRegenerationService.call(@character)

    assert_equal initial_health, @character.health
    assert_equal initial_mana, @character.mana
  end

  test "should regenerate health and mana four times" do
    @character.update(last_regeneration_at: 4.minutes.ago)

    assert @character.health < @character.max_health
    assert @character.mana < @character.max_mana

    initial_health = @character.health
    initial_mana = @character.mana
    health_regen = @character.calculate_health_regen
    mana_regen = @character.calculate_mana_regen
    expected_health = [ initial_health + 4 * health_regen, @character.max_health ].min
    expected_mana = [ initial_mana + 4 * mana_regen, @character.max_mana ].min

    CharacterRegenerationService.call(@character)

    assert_equal expected_health, @character.health
    assert_equal expected_mana, @character.mana
  end

  test "should regenerate full health and mana " do
    @character.update(last_regeneration_at: 1.day.ago)

    assert @character.health < @character.max_health
    assert @character.mana < @character.max_mana

    CharacterRegenerationService.call(@character)

    assert_equal @character.max_health, @character.health
    assert_equal @character.max_mana, @character.mana
  end
end
