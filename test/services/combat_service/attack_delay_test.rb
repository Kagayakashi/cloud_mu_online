require "test_helper"

module CombatService
  class AttackDelayTest < ActiveSupport::TestCase
    def setup
      @service = CombatService::AttackDelay.new

      def @service.session
        @session ||= {}
      end
    end

    test "should be able to attack with no delay" do
      assert @service.can_attack?
    end

    test "should not be allowed to attack with delay" do
      @service.set_delay
      assert_not @service.can_attack?
    end

    test "should return delay value" do
      @service.set_delay
      assert_equal 3, @service.delay_left
    end
  end
end
