require "test_helper"

class MapTest < ActiveSupport::TestCase
  def setup
    @map = maps(:one)
  end

  test "should not be valid with empty attributes" do
    map = Map.new
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
