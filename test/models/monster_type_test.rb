require "test_helper"

class MonsterTypeTest < ActiveSupport::TestCase
  def setup
    @spiders_map = maps(:two)
    @exist_monster_type = monster_types(:spider)
    @attributes = {
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
    }
    @monster_type = MonsterType.new(@attributes)
  end

  test "should be valid precreated monster type" do
    assert @monster_type.valid?
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
    @monster_type.name = @exist_monster_type.name
    assert_not @monster_type.valid?
  end

  test "should not be valid with incorrect level" do
    @monster_type.level = 0
    assert_not @monster_type.valid?
    @monster_type.level = -1
    assert_not @monster_type.valid?
  end

  test "should not be valid with incorrect health" do
    @monster_type.health = 0
    assert_not @monster_type.valid?
    @monster_type.health = -1
    assert_not @monster_type.valid?
  end

  test "should not be valid with incorrect min attack" do
    @monster_type.min_attack = -1
    assert_not @monster_type.valid?

    @monster_type.min_attack = 2
    @monster_type.max_attack = 1
    assert_not @monster_type.valid?
  end

  test "should not be valid with incorrect max attack" do
    @monster_type.max_attack = 0
    assert_not @monster_type.valid?
    @monster_type.max_attack = -1
    assert_not @monster_type.valid?
  end

  test "should not be valid with incorrect attack rate" do
    @monster_type.attack_rate = -1
    assert_not @monster_type.valid?
  end

  test "should not be valid with incorrect defense rate" do
    @monster_type.defense_rate = -1
    assert_not @monster_type.valid?
  end

  test "should not be valid with incorrect defense" do
    @monster_type.defense = -1
    assert_not @monster_type.valid?
  end

  test "should be valid build from map" do
    type = @spiders_map.monster_types.build(@attributes)
    assert type.valid?
  end
end
