require "test_helper"

class PasswordsControllerTest < ActionController::TestCase
  def setup
    @user = users(:three)
    session[:user_id] = @user.id
  end

  test "should change password with correct attributes" do
    post :update, params: {
      user: {
        password: "passwordNew",
        password_confirmation: "passwordNew",
        password_challenge: "password3"
      }
    }

    assert_redirected_to settings_path
    assert_equal "Your password has been updated successfully.", flash[:notice]
  end

  test "should not change password with invalid attributes" do
    post :update, params: {
      user: {
        password: "password3",
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
