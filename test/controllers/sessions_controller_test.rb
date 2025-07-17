require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should login with correct credentials" do
    post session_path, params: { user: { email: "user1@example.com", password: "password1" } }
    assert_redirected_to characters_path
  end

  test "should not login with wrong credentials" do
    post session_path, params: { user: { email: "unknowm@example.com", password: "unknown" } }
    assert_redirected_to new_session_path
    assert_equal "Invalid email or password.", flash[:alert]
  end

  test "should login and logout" do
    post session_path, params: { user: { email: "user1@example.com", password: "password1" } }
    assert_redirected_to characters_path

    post :destroy
    assert_redirected_to root_path
    assert_equal "You have been logged out.", flash[:notice]
  end
end
