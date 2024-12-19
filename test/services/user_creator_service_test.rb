require "test_helper"

class UserCreatorServiceTest < ActiveSupport::TestCase
  test "should successfully creates a user" do
    service = UserCreatorService.new
    user = service.call
    assert user.persisted?, "User should be persisted in the database"
  end

  test "should successfully creates 10 users" do
    10.times do
      service = UserCreatorService.new
      user = service.call
      assert user.persisted?, "User should be persisted in the database"
    end
  end
end
