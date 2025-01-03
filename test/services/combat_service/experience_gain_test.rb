require "test_helper"

module CombatService
  class ExperienceGainTest < ActiveSupport::TestCase
    def setup
      @spider = monsters(:one)
      @exp_box = monsters(:expbox)
      @user = users(:one)
      @character_20 = characters_characters(:one)
      @character_1 = characters_characters(:three)
    end

    test "should have not enough exp to level up" do
      ExperienceGain.call(monster: @spider, player_character: @character_20)
      assert_equal 20, @character_20.level
    end

    test "should have enough exp to level up" do
      ExperienceGain.call(monster: @spider, player_character: @character_1)
      assert_equal 2, @character_1.level
    end

    test "should level up multiple times from a lot exp" do
      @character_1.level = 1
      ExperienceGain.call(monster: @exp_box, player_character: @character_1)
      assert_operator @character_1.level, :>=, 3
    end
  end
end
