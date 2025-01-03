require "test_helper"

class CombatServiceTest < ActiveSupport::TestCase
  def setup
    @strong_attacker = characters_characters(:five)
    @spider = monsters(:one)
    @session = {}
  end

  test "should kill spider, receive rewards and get logs" do
    assert_difference("GameLogs::DamageDealtLog.count", 1) do
      assert_difference("GameLogs::ExperienceGainedLog.count", 1) do
        assert_difference("GameLogs::LootReceivedLog.count", 1) do
          CombatService.call(attacker: @strong_attacker, defender: @spider, session: @session)
        end
      end
    end

    assert @spider.dead
  end
end
