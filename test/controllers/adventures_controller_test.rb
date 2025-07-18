require "test_helper"

class AdventuresControllerTest < ActionDispatch::IntegrationTest
  def setup
    user = users(:one)
    start_new_session_for(user)
    @character = characters_players(:one)
    @lorencia = maps(:lorencia)

    @tavern = locations(:amy)
    @blacksmith = locations(:hanzo)
    @mage = locations(:pasi)
    @spiders = locations(:spiders)
  end

  test "should open adventure" do
    get adventure_path
    assert_response :success
  end

  test "should travel in Lorencia to tavern" do
    assert_equal @character.map, @lorencia

    post travel_adventure_path, params: { location_id: @tavern.id }
    assert_redirected_to adventure_path

    @character.reload
    assert_equal @character.location, @tavern
  end

  test "should travel in Lorencia to blacksmith" do
    assert_equal @character.map, @lorencia

    post travel_adventure_path, params: { location_id: @blacksmith.id }
    @character.reload

    assert_equal @character.location, @blacksmith
  end

  test "should travel in Lorencia to mage" do
    assert_equal @character.map, @lorencia

    post travel_adventure_path, params: { location_id: @mage.id }
    @character.reload

    assert_equal @character.location, @mage
  end

  test "should travel in Lorencia to spiders" do
    assert_equal @character.map, @lorencia

    post travel_adventure_path, params: { location_id: @spiders.id }
    @character.reload

    assert_equal @character.location, @spiders
  end

  test "should not travel to unknown map" do
    post travel_adventure_path, params: { location_id: 322 }
    @character.reload

    assert_redirected_to adventure_path
    assert_equal "You cannot go there.", flash[:alert]
    assert_nil @character.location
  end
end
