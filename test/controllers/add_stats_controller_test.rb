require "test_helper"

class AddStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)
    start_new_session_for(user)
    Current.character.update(points: 5)
  end

  test "should increase strength by 1 and redirect" do
    assert_difference("Current.character.reload.strength", 1) do
      post add_strength_path
    end

    assert_redirected_to character_path(Current.character)
    assert_match "Strength increased", flash[:notice]
  end

  test "should increase agility by 1 and redirect" do
    assert_difference("Current.character.reload.agility", 1) do
      post add_agility_path
    end

    assert_redirected_to character_path(Current.character)
    assert_match "Agility increased", flash[:notice]
  end

  test "should increase vitality by 1 and redirect" do
    assert_difference("Current.character.reload.vitality", 1) do
      post add_vitality_path
    end

    assert_redirected_to character_path(Current.character)
    assert_match "Vitality increased", flash[:notice]
  end

  test "should increase energy by 1 and redirect" do
    assert_difference("Current.character.reload.energy", 1) do
      post add_energy_path
    end

    assert_redirected_to character_path(Current.character)
    assert_match "Energy increased", flash[:notice]
  end
end
