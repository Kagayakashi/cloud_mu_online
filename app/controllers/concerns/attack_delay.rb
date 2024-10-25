module AttackDelay
  extend ActiveSupport::Concern

  DELAY_SECONDS = 3.0

  included do
    helper_method :set_attack_delay, :attack_delay_left, :can_attack?
  end

  private
    def set_attack_delay
      session[:character_attack_delay] = Time.now.to_f.round(1) + DELAY_SECONDS
    end

    def attack_delay_left
      return 0 if can_attack?
      attack_delay - Time.now.to_f
    end

    def can_attack?
      return true if attack_delay.nil?
      attack_delay < Time.now.to_f
    end

    def attack_delay
      session[:character_attack_delay].to_f
    end
end
