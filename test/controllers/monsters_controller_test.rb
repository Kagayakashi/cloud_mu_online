require "test_helper"

class MonstersControllerTest < ActionController::TestCase
  setup do
    @monster = monsters(:one)
    @user = users(:one)
    session[:user_id] = @user.id
  end

  test "should perform physical attack to monster and reduce monster health" do
    initial_monster_health = @monster.health

    post :receive_attack_damage, params: { id: @monster.id }
    assert_redirected_to adventure_path

    @monster.reload
    assert @monster.health < initial_monster_health
  end

  test "should perform physical attack to monster and become monster target" do
    post :receive_attack_damage, params: { id: @monster.id }
    assert_redirected_to adventure_path

    @monster.reload
    assert_same @user.id, @monster.target_id
  end
end
