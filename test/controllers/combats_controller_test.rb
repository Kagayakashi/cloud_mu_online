require "test_helper"

class CombatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)
    start_new_session_for(user)
    @monster = characters_monsters(:spider)
    @character = Current.character
  end

  test "should win against monster" do
    initial_xp = @character.experience
    initial_gold = @character.gold

    post combat_path, params: { character_id: @monster.id }
    assert_redirected_to combat_path

    @character.reload

    assert @character.experience > initial_xp
    assert @character.gold > initial_gold
  end
end
