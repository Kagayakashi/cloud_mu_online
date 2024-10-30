require "test_helper"

class CharactersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    session[:user_id] = @user.id
  end

  test "should create character and redirect" do
    assert_difference("Characters::Character.count", 1) do
      post :create, params: { characters_character: { name: "CreatedDarkKnight2", type: "Characters::DarkKnight" } }
    end
    assert_redirected_to characters_path
    assert_equal "Character created successfully.", flash[:notice]
  end

  test "should render new on invalid character type" do
    assert_no_difference "Characters::Character.count" do
      post :create, params: { characters_character: { name: "InvalidTypeCharacter", type: "Characters::InvalidType" } }
    end

    assert_response :unprocessable_entity
    assert_template :new
    assert_match /is not a valid character type/, response.body
  end

  test "should render new on empty name" do
    assert_no_difference "Characters::Character.count" do
      post :create, params: { characters_character: { name: "", type: "Characters::DarkKnight" } }
    end
    assert_response :unprocessable_entity
    assert_template :new
    assert_match /can&#39;t be blank/, response.body
  end
end
