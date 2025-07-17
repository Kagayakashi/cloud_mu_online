require "test_helper"

class CharactersControllerTest < ActionDispatch::IntegrationTest
  def setup
    user = users(:one)
    start_new_session_for(user)
  end

  test "should create character and redirect" do
    assert_difference("Characters::Character.count", 1) do
      post characters_path, params: { characters_character: { name: "DarkKnightCntrl", type: "Characters::DarkKnight" } }
    end

    assert_redirected_to characters_path
    assert_equal "Character created successfully.", flash[:notice]
  end

  test "should render new on invalid character type" do
    assert_no_difference "Characters::Character.count" do
      post characters_path, params: { characters_character: { name: "InvalidTypeCharacter", type: "Characters::InvalidType" } }
    end

    assert_response :unprocessable_entity
  end

  test "should render new on empty name" do
    assert_no_difference "Characters::Character.count" do
      post characters_path, params: { characters_character: { name: "", type: "Characters::DarkKnight" } }
    end

    assert_response :unprocessable_entity
  end
end
