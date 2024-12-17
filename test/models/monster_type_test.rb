require "test_helper"

class MonsterTypeTest < ActiveSupport::TestCase
  def setup
    @spiders_map = maps(:two)
  end

  test "should not be valid with empty all attributes" do
    type = MonsterType.new
    assert_not type.valid?
  end

  test "should not be valid with name and map only" do
    type = MonsterType.new(name: "I Have Only Name", map: @spiders_map)
    assert_not type.valid?
  end

  test "should be valid with filled all attributes" do
    type = MonsterType.new(
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
      map: @spiders_map
    )
    assert type.valid?
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
