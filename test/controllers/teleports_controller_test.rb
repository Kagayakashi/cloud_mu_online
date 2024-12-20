require "test_helper"

class TeleportsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    session[:user_id] = @user.id
    @character = characters_characters(:one)
    @lorencia = maps(:one)
    @spiders = maps(:two)
    @budge_dragons = maps(:three)
    @devias = maps(:four)
  end

  test "should teleport to lorencia with 1000 gold" do
    @character.update(gold: 1000)
    post :create, params: { id: @lorencia.id }
    assert_redirected_to adventure_path
    assert_equal "Teleported to #{ @lorencia.name }.", flash[:notice]
  end

  test "should not teleport to lorencia with 0 gold" do
    @character.update(gold: 0)
    post :create, params: { id: @lorencia.id }
    assert_redirected_to new_teleport_path
    assert_equal "You have not enough gold to teleport to #{ @lorencia.name }.", flash[:alert]
  end

  test "should not teleport to devias with level 1" do
    @character.update(level: 1)
    post :create, params: { id: @devias.id }
    assert_redirected_to new_teleport_path
    assert_equal "Your level is too low to teleport to #{ @devias.name }.", flash[:alert]
  end

  test "should not teleport to spiders" do
    post :create, params: { id: @spiders.id }
    assert_redirected_to new_teleport_path
    assert_equal "You cannot teleport to #{ @spiders.name }.", flash[:alert]
  end

  test "should not teleport to budge dragons" do
    post :create, params: { id: @budge_dragons.id }
    assert_redirected_to new_teleport_path
    assert_equal "You cannot teleport to #{ @budge_dragons.name }.", flash[:alert]
  end
end
