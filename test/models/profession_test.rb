require "test_helper"

class ProfessionTest < ActiveSupport::TestCase
  test "should not be valid with level 0" do
    prof = Profession.new(name: "Invalid level profession", level: 0)
    assert_not prof.valid?
  end

  test "should not be valid with empty level" do
    prof = Profession.new(name: "Empty level profession", code: "test")
    assert_not prof.valid?
  end

  test "should not be valid with empty code" do
    prof = Profession.new(name: "Empty code profession", level: 150)
    assert_not prof.valid?
  end

  test "should be valid with attributes" do
    prof = Profession.new(name: "Grand Master", code: "gm", level: 400)
    assert prof.valid?
  end

  test "should be created with attributes" do
    prof = Profession.new(name: "Grand Master", code: "gm", level: 400)
    assert prof.save
  end
end
