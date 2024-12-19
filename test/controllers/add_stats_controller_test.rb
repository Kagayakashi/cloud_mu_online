require "test_helper"

class AddStatsControllerTest < ActionController::TestCase
  def setup
    user = users(:one)
    session[:user_id] = user.id
    @character = characters_characters(:one)
  end

  test "should increase strength by 1 and redirect" do
    assert_difference("@character.reload.strength", 1) do
      post :strength
    end
    assert_redirected_to character_path(@character)
    assert_equal "Strength increased.", flash[:notice]
  end

  test "should increase agility by 1 and redirect" do
    assert_difference("@character.reload.agility", 1) do
      post :agility
    end
    assert_redirected_to character_path(@character)
    assert_equal "Agility increased.", flash[:notice]
  end

  test "should increase vitality by 1 and redirect" do
    assert_difference("@character.reload.vitality", 1) do
      post :vitality
    end
    assert_redirected_to character_path(@character)
    assert_equal "Vitality increased.", flash[:notice]
  end

  test "should increase energy by 1 and redirect" do
    assert_difference("@character.reload.energy", 1) do
      post :energy
    end
    assert_redirected_to character_path(@character)
    assert_equal "Energy increased.", flash[:notice]
  end
end
