module CombatService
  class QuickCombat
    MAX_ROUNDS = 25

    def self.call(player:, target:)
      instance = new(player: player, target: target)
      instance.start
      instance
    end

    def initialize(player:, target:)
      @player = player
      @target = target
      @attacker, @defender = [ @player, @target ].shuffle
    end

    def start
      round = 1
      while both_alive? && round <= MAX_ROUNDS do
        QuickEngagement.call(attacker: @attacker, defender: @defender)
        break unless both_alive?
        round += 1
        buf = @attacker
        @attacker = @defender
        @defender = buf
      end

      determine_winner
    end

    private

    def both_alive?
      @attacker.hp > 0 && @defender.hp > 0
    end

    def determine_winner
      winner = @attacker.hp > 0 ? @attacker : @defender
      loser = winner == @attacker ? @defender : @attacker
      log(winner, loser)

      if loser.is_a? MonsterType
        ExperienceGain.call(monster_type: loser, player_character: winner)
      end
    end

    def log(winner, loser)
      if winner.is_a? Characters::Character
        GameLogs::ExperienceGainedLog.create(
          character: winner,
          description: "You won battle."
        )
      end

      if loser.is_a? Characters::Character
        GameLogs::DamageReceivedLog.create(
          character: loser,
          description: "You lose battle."
        )
      end
    end
  end
end
