require "test_helper"

class CharacterCreatorServiceTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test "should successfully create a character" do
    service = CharacterCreatorService.new(user: @user, name: "ServiceTestDK1", type: "Characters::DarkKnight")
    character = service.call
    assert character.persisted?, "Character should be persisted in the database"
    assert_equal "ServiceTestDK1", character.name
    assert_equal "Characters::DarkKnight", character.type
  end

  test "should not be persisted when type is invalid" do
    service = CharacterCreatorService.new(user: @user, name: "InvalidTypeCharacter", type: "Characters::InvalidType")
    character = service.call
    assert_not character.persisted?
  end

  test "should not be persisted when name is blank" do
    service = CharacterCreatorService.new(user: @user, name: "", type: "Characters::DarkKnight")
    character = service.call
    assert_not character.persisted?
  end
end
