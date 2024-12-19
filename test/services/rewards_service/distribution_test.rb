require "test_helper"

module RewardsService
  class DistributionTest < ActiveSupport::TestCase
    def setup
      @monster = monsters(:one)
      @user = users(:one)
      @player_character = Characters::DarkKnight.new(name: "TestCharGetRewards", user: @user)
      @player_character.save
    end

    test "should distribute experience and gold per monster" do
      initial_experience = @player_character.experience
      initial_gold = @player_character.gold
      initial_level = @player_character.level

      assert_equal 1, @player_character.level

      RewardsService::Distribution.call(monster: @monster, player_character: @player_character)

      assert_operator @player_character.experience, :>, initial_experience
      assert_operator @player_character.level, :>, initial_level
      assert_operator @player_character.gold, :>, initial_gold
    end
  end
end
