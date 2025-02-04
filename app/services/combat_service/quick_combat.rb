module CombatService
  class QuickCombat
    def self.call(player:, target:)
      instance = new(player: player, target: target)
      instance.attack
      instance
    end

    def initialize(player:, target:)
      @player = player
      @target = target
      @attacker, @defender = [ @player, @target ].shuffle
    end

    def attack
      # Todo
      # while  do
    end
  end
end
