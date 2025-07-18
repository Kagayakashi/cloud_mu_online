require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should login with correct credentials" do
    post session_path, params: { email: "user1@example.com", password: "password" }
    assert_redirected_to characters_path
  end

  test "should not login with wrong credentials" do
    post session_path, params: { email: "unknowm@example.com", password: "unknown" }
    assert_redirected_to new_session_path
    assert_equal "Try another email address or password.", flash[:alert]
  end

  test "should login and logout" do
    post session_path, params: { email: "user1@example.com", password: "password" }
    assert_redirected_to characters_path

    delete session_path
    assert_redirected_to root_path
  end
end
