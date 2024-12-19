require "test_helper"

class MonstersControllerTest < ActionController::TestCase
  setup do
    @monster = monsters(:one)
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

  test "should set monster target after attack" do
    post :receive_attack_damage, params: { id: @monster.id }
    assert_redirected_to adventure_path

    @monster.reload
    assert_equal @character, @monster.target
  end

  test "should not attack too often" do
    initial_health = @monster.health

    post :receive_attack_damage, params: { id: @monster.id }
    assert_redirected_to adventure_path
    assert_nil flash[:alert]

    post :receive_attack_damage, params: { id: @monster.id }
    assert_redirected_to adventure_path
    assert_equal "You cannot attack so often.", flash[:alert]
  end
end
