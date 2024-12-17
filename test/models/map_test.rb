require "test_helper"

class MapTest < ActiveSupport::TestCase
  def setup
    @map = maps(:one)
  end

  test "should not be valid with empty attributes" do
    map = Map.new
    assert_not map.valid?
  end

  test "should not be valid with incorrect min level" do
    map = Map.new(name: "I Have Only Name", min_level: 0)
    assert_not map.valid?

    map = Map.new(name: "I Have Only Name", min_level: -1)
    assert_not map.valid?
  end

  test "should not be valid with incorrect teleport min level" do
    map = Map.new(name: "I Have Only Name", teleport_min_level: 0)
    assert_not map.valid?

    map = Map.new(name: "I Have Only Name", teleport_min_level: -1)
    assert_not map.valid?
  end

  test "should not be valid with incorrect teleport cost" do
    map = Map.new(name: "I Have Only Name", teleport_min_level: -1)
    assert_not map.valid?
  end

  test "should be valid with name" do
    map = Map.new(name: "I Have Only Name")
    assert_equal 1, map.min_level
    assert_equal false, map.can_teleport
    assert_equal 1, map.teleport_min_level
    assert_equal 1000, map.teleport_cost
    assert map.valid?
  end

  test "should not be valid with already existing name" do
    map = Map.new(name: @map.name)
    assert_not map.valid?
  end
end
