require "test_helper"

class RegistrationsControllerTest < ActionController::TestCase
  test "should register with correct credentials" do
    assert_difference("User.count", 1) do
      post :create, params: { user: {
        username: "user101",
        email: "user101@example.com",
        password: "passwordtest",
        password_confirmation: "passwordtest"
      } }
    end
    assert_redirected_to root_path
  end

  test "should fail register with invalid email" do
    post :create, params: { user: {
      username: "user102",
      email: "wrong_email",
      password: "passwordtest",
      password_confirmation: "passwordtest"
    } }
    assert_response :unprocessable_entity
    assert_template :new
    assert_match (/Email is invalid/), response.body
  end

  test "should fail register with already taken email" do
    post :create, params: { user: {
      username: "user103",
      email: users(:one).email,
      password: "passwordtest",
      password_confirmation: "passwordtest"
    } }
    assert_response :unprocessable_entity
    assert_template :new
    assert_match (/Email has already been taken/), response.body
  end

  test "should fail register with already taken username" do
    post :create, params: { user: {
      username: users(:one).username,
      email: "user104@example.com",
      password: "passwordtest",
      password_confirmation: "passwordtest"
    } }
    assert_response :unprocessable_entity
    assert_template :new
    assert_match (/Username has already been taken/), response.body
  end
end
