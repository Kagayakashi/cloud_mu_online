module CombatService
  def self.call(attacker:, defender:, session:)
    combat = Engagement.call(attacker: attacker, defender: defender, session: session)
    attacker.save if attacker.changed?
    defender.save if defender.changed?
    combat
  end
end
