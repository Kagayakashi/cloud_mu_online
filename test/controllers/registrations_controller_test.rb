require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    user = users(:four)
    start_new_session_for(user)
  end

  test "should register with correct credentials" do
    post registration_path, params: { user: {
      username: "user101",
      email: "user101@example.com",
      password: "passwordtest",
      password_confirmation: "passwordtest"
    } }

    Current.user.reload

    assert_not Current.user.is_guest
    assert_redirected_to settings_path
  end

  test "should fail register with invalid email" do
    post registration_path, params: { user: {
      username: "user102",
      email: "wrong_email",
      password: "passwordtest",
      password_confirmation: "passwordtest"
    } }
    assert_response :unprocessable_entity
  end

  test "should fail register with already taken email" do
    post registration_path, params: { user: {
      username: "user103",
      email: users(:one).email,
      password: "passwordtest",
      password_confirmation: "passwordtest"
    } }
    assert_response :unprocessable_entity
  end

  test "should fail register with already taken username" do
    post registration_path, params: { user: {
      username: users(:one).username,
      email: "user104@example.com",
      password: "passwordtest",
      password_confirmation: "passwordtest"
    } }
    assert_response :unprocessable_entity
  end
end
