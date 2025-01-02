require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @other_character = characters_characters(:three)
    @other_user = users(:two)
  end

  test "should be valid when user has a player" do
    assert @user.player.present?
  end

  test "should not be valid when user already has a player" do
    player = @user.build_player(character: @character)
    assert_not player.valid?
  end

  test "should not be created when user already has a player" do
    player = @user.create_player(character: @character)
    assert_not player.valid?
  end

  test "should not be valid when other user uses already existing player" do
    player = @other_user.create_player(character: @user.player.character)
    assert_not player.valid?
  end
end
