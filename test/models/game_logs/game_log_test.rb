require "test_helper"

module GameLogs
  class GameLogTest < ActiveSupport::TestCase
    def setup
      @character = characters_characters(:one)
    end

    test "should not be valid with empty attributes" do
      log = GameLogs::GameLog.new
      assert_not log.valid?
    end

    test "shoud be valid with character and text" do
      log = GameLogs::GameLog.new(character: @character, description: "Log has been created for character #{@character.name}")
      assert log.valid?
    end

    test "shoud create log" do
      log = GameLogs::GameLog.create(character: @character, description: "Log has been created for character #{@character.name}")
      assert log.persisted?
    end
  end
end
