require "test_helper"

class CharacterTest < ActiveSupport::TestCase
  test "should be valid with attributes" do
    user1 = users(:one)
    dw = professions(:dw)

    character = user1.characters.new(name: 'Dark Wizard 1', profession: dw)
    assert character.valid?
  end
end
