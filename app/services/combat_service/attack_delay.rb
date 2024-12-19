module CombatService
  class AttackDelay
    DELAY_SECONDS = 3.0.freeze

    def initialize(session)
      @session = session
    end

    def delay_left
      return 0 if can_attack?
      (delay - Time.now.to_f).round(2)
    end

    def set_delay
      @session[:character_can_attack_at] = Time.now.to_f + DELAY_SECONDS
    end

    def can_attack?
      return true if delay.nil?
      delay < Time.now.to_f
    end

    private

    def delay
      @session[:character_can_attack_at].to_f
    end
  end
end
