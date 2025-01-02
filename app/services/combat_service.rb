module CombatService
  def self.call(attacker:, defender:, session:)
    combat = Engagement.call(attacker: attacker, defender: defender, session: session)

    # If attack is a Player
    if attacker.is_a? Characters::Character
      if combat.success
        GameLogs::DamageDealtLog.create(character: attacker, description: "You dealt #{combat.total_damage} damage to #{defender.name}.")
      end
    end

    # If defeneder is a Player
    if defender.is_a? Characters::Character
      if combat.success
        GameLogs::DamageReceivedLog.create(character: defender, description: "You received #{combat.total_damage} damage from #{attacker.name}.")
      end
    end

    combat
  end
end
