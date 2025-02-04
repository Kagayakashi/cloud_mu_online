require "test_helper"

class StartsControllerTest < ActionController::TestCase
  test "should create user and character and redirect" do
    assert_difference("Characters::Character.count", 1) do
      post :create, params: { characters_character: { name: "CreatedDarkKnight3", type: "Characters::DarkKnight" } }
    end
    assert_redirected_to adventure_path
  end

  test "should render new on invalid character type" do
    assert_no_difference "Characters::Character.count" do
      post :create, params: { characters_character: { name: "InvalidTypeCharacter", type: "Characters::InvalidType" } }
    end

    assert_response :unprocessable_entity
    assert_match (/is not a valid character type/), response.body
  end

  test "should render new on empty name" do
    assert_no_difference "Characters::Character.count" do
      post :create, params: { characters_character: { name: "", type: "Characters::DarkKnight" } }
    end
    assert_response :unprocessable_entity
    assert_match (/can&#39;t be blank/), response.body
  end
end
