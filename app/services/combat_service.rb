module CombatService
  def self.call(player:, target:)
    combat = QuickCombat.call(player: player, target: target)
    player.save! if player.changed?
    target.save! if target.changed?
    combat
  end
end
