require "test_helper"

class MonsterTypeTest < ActiveSupport::TestCase
  def setup
    @spiders_map = maps(:two)
    @monster_type = monster_types(:spider)
    @temp_type = MonsterType.new(
      name: "White Rabbit",
      level: 5,
      health: 1000,
      min_attack: 0,
      max_attack: 1,
      attack_rate: 0,
      defense_rate: 0,
      defense: 0,
      experience: 100,
      spawn_time: 60,
      map: @spiders_map
    )
  end

  test "should be valid precreated monster type" do
    assert @temp_type.valid?
  end

  test "should not be valid with empty all attributes" do
    type = MonsterType.new
    assert_not type.valid?
  end

  test "should not be valid with name and map only" do
    type = MonsterType.new(name: "I Have Only Name", map: @spiders_map)
    assert_not type.valid?
  end

  test "should not be valid with incorrect attributes existing name" do
    @temp_type.name = @monster_type.name
    assert_not @temp_type.valid?
  end

  test "should not be valid with incorrect level" do
    @temp_type.level = 0
    assert_not @temp_type.valid?
    @temp_type.level = -1
    assert_not @temp_type.valid?
  end

  test "should not be valid with incorrect health" do
    @temp_type.health = 0
    assert_not @temp_type.valid?
    @temp_type.health = -1
    assert_not @temp_type.valid?
  end

  test "should not be valid with incorrect min attack" do
    @temp_type.min_attack = -1
    assert_not @temp_type.valid?

    @temp_type.min_attack = 2
    @temp_type.max_attack = 1
    assert_not @temp_type.valid?
  end

  test "should not be valid with incorrect max attack" do
    @temp_type.max_attack = 0
    assert_not @temp_type.valid?
    @temp_type.max_attack = -1
    assert_not @temp_type.valid?
  end

  test "should not be valid with incorrect attack rate" do
    @temp_type.attack_rate = -1
    assert_not @temp_type.valid?
  end

  test "should not be valid with incorrect defense rate" do
    @temp_type.defense_rate = -1
    assert_not @temp_type.valid?
  end

  test "should not be valid with incorrect defense" do
    @temp_type.defense = -1
    assert_not @temp_type.valid?
  end

  test "should be valid build from map" do
    type = @spiders_map.monster_types.build(
      name: "White Rabbit",
      level: 5,
      health: 1000,
      min_attack: 1,
      max_attack: 1,
      attack_rate: 1,
      defense_rate: 1,
      defense: 1,
      experience: 100,
      spawn_time: 60,
    )
    assert type.valid?
  end
end
