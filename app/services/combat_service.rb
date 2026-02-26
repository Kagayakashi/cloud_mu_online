module CombatService
  def self.call(player:, target:)
    QuickCombat.call(player: player, target: target)
    player.save! if player.changed?

    target.save! if target.changed? && target.is_a?(Characters::Player)
  end
end
