require "test_helper"

class CombatServiceTest < ActiveSupport::TestCase
  def setup
    @player = characters_characters(:one)
    @spider = characters_monsters(:one)
  end

  test "player character should win against spider" do
    xp_before = @player.experience
    CombatService.call(player: @player, target: @spider)
    @player.reload
    assert @player.experience > xp_before, "Experience should increase"
  end
end
