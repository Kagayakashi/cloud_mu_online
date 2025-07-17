require "test_helper"

class MapTest < ActiveSupport::TestCase
  def setup
    @map = maps(:lorencia)
  end

  test "should not be valid with empty attributes" do
    map = Map.new
    assert_not map.valid?
  end

  test "should not be valid with incorrect min level" do
    map = Map.new(name: "I Have Only Name", level: 0)
    assert_not map.valid?

    map = Map.new(name: "I Have Only Name", level: -1)
    assert_not map.valid?
  end

  test "should be valid" do
    map = Map.new(name: "I Have Only Name")
    assert_equal 1, map.level
    assert map.valid?
  end

  test "should not be valid with already existing name" do
    map = Map.new(name: @map.name)
    assert_not map.valid?
  end
end
