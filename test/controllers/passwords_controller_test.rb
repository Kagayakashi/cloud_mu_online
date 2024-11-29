require "test_helper"

class PasswordsControllerTest < ActionController::TestCase
  def setup
    @user = users(:three)
    session[:user_id] = @user.id
  end

  test "should change password with correct attributes" do
    post :update, params: { password: "passwordNew", password_confirmation: "passwordNew", password_challenge: "password3" }
    assert_redirected_to edit_password_path
    assert_equal "Your password has been updated successfully.", flash[:notice]
  end

  test "should not change password with invalid attributes" do
    post :update, params: { password: "passwordNew", password_confirmation: "passwordNew", password_challenge: "qqqq" }
    assert_response :unprocessable_entity
    assert_template :edit
  end
end
