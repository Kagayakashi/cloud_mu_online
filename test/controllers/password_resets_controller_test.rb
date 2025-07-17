require "test_helper"

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  def setup
    @user = users(:one)
  end

  test "should send password reset email" do
    assert_emails 1 do
      post password_resets_path, params: { email: @user.email }
    end

    assert_redirected_to new_session_path
    assert_equal "Password reset instructions sent (if user with that email address exists).", flash[:notice]
  end

  test "should not send email for non-existent user" do
    assert_no_emails do
      post password_resets_path, params: { email: "nonexistent@example.com" }
    end

    assert_redirected_to new_session_path
    assert_equal "Password reset instructions sent (if user with that email address exists).", flash[:notice]
  end

  test "should display password reset form with valid token" do
    token = @user.generate_token_for(:password_reset)
    get edit_password_reset_path(token), params: { token: token }

    assert_response :success
    assert_select "form"
  end

  test "should redirect with invalid token" do
    get edit_password_reset_path, params: { token: "invalid" }
    assert_redirected_to new_password_reset_path
    assert_equal "Invalid token, please try again.", flash[:alert]
  end

  test "should update password with valid data" do
    token = @user.generate_token_for(:password_reset)
    patch password_reset_path(token), params: {
      token: token,
      user: { password: "newpassword", password_confirmation: "newpassword" }
    }

    assert_redirected_to new_session_path
    assert_equal "Password has been reset.", flash[:notice]
  end

  test "should show errors when passwords do not match" do
    token = @user.generate_token_for(:password_reset)
    patch password_reset_path(token), params: {
      token: token,
      user: { password: "newpassword", password_confirmation: "wrongpassword" }
    }

    assert_response :unprocessable_entity
    assert_select "div.errors"
  end
end
