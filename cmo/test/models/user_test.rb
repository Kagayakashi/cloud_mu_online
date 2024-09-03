require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should be valid with attributes" do
    user = User.new(
      username: 'user',
      email: 'user@example.com',
      password: 'password123',
      password_confirmation: 'password123',
    )

    assert user.valid?
  end

  test "should not be valid without an email" do
    user = User.new(
      username: 'user',
      password: 'password123',
      password_confirmation: 'password123',
    )

    assert_not user.valid?
  end

  test "should not be valid with bad email" do
    user = User.new(
      username: 'user',
      email: 'user email',
      password: 'password123',
      password_confirmation: 'password123',
    )

    assert_not user.valid?
  end

  test "should be created valid user" do
    user = User.new(
      username: 'testmodeluser',
      email: 'testmodeluser@example.com',
      password: 'password123',
      password_confirmation: 'password123',
    )

    assert user.save
  end
end
