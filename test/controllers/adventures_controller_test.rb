require "test_helper"

class AdventuresControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    session[:user_id] = @user.id
    @character = characters_characters(:one)
    @lorencia = maps(:one)

    @tavern = locations(:one)
    @blacksmith = locations(:two)
    @mage = locations(:three)
    @spiders = locations(:four)
  end

  test "should travel in Lorencia to tavern" do
    assert_equal @character.map, @lorencia

    post :travel, params: { id: @tavern.id }
    @character.reload

    assert_equal @character.map, @tavern
  end

  test "should travel in Lorencia to blacksmith" do
    assert_equal @character.map, @lorencia

    post :travel, params: { id: @blacksmith.id }
    @character.reload

    assert_equal @character.map, @blacksmith
  end

  test "should travel in Lorencia to mage" do
    assert_equal @character.map, @lorencia

    post :travel, params: { id: @mage.id }
    @character.reload

    assert_equal @character.map, @mage
  end

  test "should travel in Lorencia to spiders" do
    assert_equal @character.map, @lorencia

    post :travel, params: { id: @spiders.id }
    @character.reload

    assert_equal @character.map, @spiders
  end

  test "should not travel to unknown map" do
    post :travel, params: { id: 322 }
    @character.reload

    assert_redirected_to adventure_path
    assert_equal "Location does not exist.", flash[:alert]
    assert_equal @character.map, @lorencia
  end
end
