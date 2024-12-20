module CombatService
  class MonsterReaction
    def self.call(monster:, character:)
      instance = new(monster: monster, character: character)
      instance.react
      instance
    end

    def initialize(monster:, character:)
      @monster = monster
      @character = character
    end

    def react
      return unless @monster.is_a? Monster

      if @monster.health > 0 && @monster.target.nil?
        @monster.update(target: @character)
        ActiveSupport::Notifications.instrument("monster.perform_attack", monster: @monster, character: @character)
      end
    end
  end
end
