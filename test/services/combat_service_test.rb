require "test_helper"

class CombatServiceTest < ActiveSupport::TestCase
  def setup
    @player = characters_characters(:three)
    @spider = characters_monsters(:one)
  end

  test "monster should die after combat" do
    CombatService.call(player: @player, target: @spider)
    @spider.reload
    assert @spider.dead?,
      "Monster should be dead after combat. Monsters health #{ @spider.health }"
  end

  test "player character should gain experience after combat" do
    xp_before = @player.experience
    CombatService.call(player: @player, target: @spider)
    @player.reload
    assert @player.experience > xp_before, "Experience should increase"
  end

  # test "player character should gain gold after combat" do
  #   gold_before = @player.gold
  #   CombatService.call(player: @player, target: @spider)
  #   @player.reload
  #   assert @player.gold > gold_before, "Gold should increase"
  # end
end
