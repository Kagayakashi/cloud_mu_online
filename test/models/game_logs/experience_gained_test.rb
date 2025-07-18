require "test_helper"

module GameLogs
  class ExperienceGainedLogTest < ActiveSupport::TestCase
    def setup
      @character = characters_players(:one)
    end

    test "should not be valid with empty attributes" do
      log = GameLogs::ExperienceGainedLog.new
      assert_not log.valid?
    end

    test "shoud be valid with character and text" do
      log = GameLogs::ExperienceGainedLog.new(character: @character, description: "Log has been created for character #{@character.name}")
      assert log.valid?
    end

    test "shoud create log" do
      log = GameLogs::ExperienceGainedLog.create(character: @character, description: "Log has been created for character #{@character.name}")
      assert log.persisted?
    end
  end
end
