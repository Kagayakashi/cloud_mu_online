require "test_helper"

class ProfessionTest < ActiveSupport::TestCase
  test "should not be valid with 0 max level" do
    prof = Profession.new(name: "Invalid max level profession", max_level: 0)
    assert_not prof.valid?
  end

  test "should not be valid with empty max level" do
    prof = Profession.new(name: "Empty max level profession")
    assert_not prof.valid?
  end

  test "should be valid with attributes" do
    prof = Profession.new(name: "Grand Master", max_level: 400)
    assert prof.valid?
  end

  test "should be created with attributes" do
    prof = Profession.new(name: "Grand Master", max_level: 400)
    assert prof.save
  end
end
