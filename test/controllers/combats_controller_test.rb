require "test_helper"

class CombatsControllerTest < ActionController::TestCase
  setup do
    @monster = characters_monsters(:spider)
    @user = users(:one)
    session[:user_id] = @user.id
    @character = @user.player.character
  end

  test "should reduce monster health after attack" do
    initial_health = @monster.health

    post :receive_attack_damage, params: { id: @monster.id }
    assert_redirected_to adventure_path

    @monster.reload
    assert @monster.health < initial_health
  end
end
