require "test_helper"

class AdventuresControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    session[:user_id] = @user.id
    @character = characters_characters(:one)
    @lorencia = maps(:one)
    @spiders = maps(:two)
    @budge_dragons = maps(:three)
  end

  test "should travel from lorencia to spiders" do
    assert_equal @character.map, @lorencia

    post :travel, params: { id: @spiders.id }
    @character.reload

    assert_equal @character.map, @spiders
  end

  test "should travel from lorencia to budge dragons cross spiders" do
    assert_equal @character.map, @lorencia

    post :travel, params: { id: @spiders.id }
    post :travel, params: { id: @budge_dragons.id }
    @character.reload

    assert_equal @character.map, @budge_dragons
  end

  test "should not travel from lorencia straight to the budge dragons" do
    assert_equal @character.map, @lorencia

    post :travel, params: { id: @budge_dragons.id }
    @character.reload

    assert_equal "You cannot go there.", flash[:alert]
    assert_equal @character.map, @lorencia
  end

  test "should not travel to unknown map" do
    post :travel, params: { id: 322 }
    @character.reload
    
    assert_redirected_to adventure_path
    assert_equal "Location does not exist.", flash[:alert]
    assert_equal @character.map, @lorencia
  end
end
