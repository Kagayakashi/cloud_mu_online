require "test_helper"

class StartsControllerTest < ActionDispatch::IntegrationTest
  test "should create user and character and redirect" do
    assert_difference("Characters::Character.count", 1) do
      post start_path, params: {
        characters_character: {
          name: "CreatedDarkKnight3",
          type: "Characters::DarkKnight"
        }
      }
    end
    assert_redirected_to adventure_path
  end

  test "should not create user and character with invalid type" do
    assert_no_difference "Characters::Character.count" do
      post start_path, params: {
        characters_character: {
          name: "InvalidTypeCharacter",
          type: "Characters::InvalidType"
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should not create user and character with empty name" do
    assert_no_difference "Characters::Character.count" do
      post start_path, params: {
        characters_character: {
          name: "",
          type: "Characters::DarkKnight"
        }
      }
    end

    assert_response :unprocessable_entity
  end
end
