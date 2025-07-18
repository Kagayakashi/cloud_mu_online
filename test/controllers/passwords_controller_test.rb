require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  def setup
    user = users(:three)
    start_new_session_for(user)
  end

  test "should change password with correct attributes" do
    patch password_path, params: {
      user: {
        password: "passwordNew",
        password_confirmation: "passwordNew",
        password_challenge: "password"
      }
    }

    assert_redirected_to settings_path
    assert_equal "Your password has been updated successfully.", flash[:notice]
  end

  test "should not change password with invalid attributes" do
    patch password_path, params: {
      user: {
        password: "password",
        password_confirmation: "passwordNew",
        password_challenge: "qqqq"
      }
    }

    assert_response :unprocessable_entity
    assert_select ".error_messages" do
      assert_select "h2"
      assert_select "ul" do |elements|
        elements.each do |element|
          assert_select element, "li", "Password confirmation doesn't match Password"
        end
      end
    end
  end
end
