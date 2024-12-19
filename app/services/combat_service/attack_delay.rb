module CombatService
  class AttackDelay
    DELAY_SECONDS = 3.0.freeze

    def set_delay
      session[:character_can_attack_at] = Time.now.to_f.round(1) + DELAY_SECONDS
    end

    def delay_left
      return 0 if can_attack?
      delay - Time.now.to_f.round(1)
    end

    def can_attack?
      return true if delay.nil?
      delay < Time.now.to_f.round(1)
    end

    private

    def delay
      session[:character_can_attack_at].to_f.round(1)
    end
  end
end
