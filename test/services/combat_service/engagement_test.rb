require "test_helper"

module CombatService
  class EngagementTest < ActiveSupport::TestCase
    def setup
      @attacker = characters_characters(:one)
      @defender = monsters(:one)
      @session = {}
    end

    test "should engage and deal damage to defender" do
      combat = Engagement.call(attacker: @attacker, defender: @defender, session: @session)
      assert_operator @defender.health, :>, 1
      assert_operator @defender.health, :<, 100
    end
  end
end
