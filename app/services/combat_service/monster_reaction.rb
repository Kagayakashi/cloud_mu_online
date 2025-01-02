module CombatService
  class MonsterReaction
    def self.call(monster:, character:)
      instance = new(monster: monster, character: character)
      instance.react
      instance
    end

    def initialize(monster:, character:)
      raise ArgumentError, "monster must be a Monster" unless monster.is_a?(Monster)
      raise ArgumentError, "character must be a Character" unless character.is_a?(Characters::Character)

      @monster = monster
      @character = character
    end

    def react
      if @monster.health > 0 && @monster.target.nil?
        @monster.update(target: @character)
        ActiveSupport::Notifications.instrument("monster.perform_attack", monster: @monster, character: @character)
      end
    end
  end
end
