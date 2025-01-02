require "test_helper"

class MonsterTest < ActiveSupport::TestCase
  def setup
    @spider_type = monster_types(:spider)
  end

  test "should not be valid with empty all attributes" do
    monster = Monster.new
    assert_not monster.valid?
  end

  test "should be valid with filled all attributes" do
    monster = Monster.new(monster_type: @spider_type)
    assert monster.valid?
    assert_equal @spider_type.health, monster.health
  end

  test "should be valid build from map" do
    monster = @spider_type.monsters.build
    assert monster.valid?
  end
end
