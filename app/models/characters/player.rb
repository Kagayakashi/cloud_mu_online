module Characters
  class Player < Character
    before_validation :calculate_params!, if: :new_record?

    belongs_to :user
    has_many :game_logs, class_name: "GameLogs::GameLog", foreign_key: "character_id", dependent: :destroy

    validates :user, presence: true

    def self.order
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def self.character_types
      subclasses.map do |subclass|
        class_name = subclass.name.demodulize
        formatted_name = class_name.gsub(/([a-z])([A-Z])/, '\1 \2').titleize
        formatted_name = class_name.titleize if formatted_name.blank?
        [ formatted_name, subclass.name ]
      end.sort_by do |_, subclass_name|
        subclass_name.constantize.order
      end
    end

    def attacks
      2
    end

    def restore
      return unless can_restore?

      self.update(last_restore_at: Time.current, activity: 100)
    end

    def regenerate
      CharacterRegenerationService.call(self)
    end

    def add_experience(xp)
      remaining_xp = xp
      new_level = self.level
      new_experience = self.experience

      while remaining_xp > 0
        xp_needed = calculate_max_experience - new_experience

        if remaining_xp >= xp_needed
          new_level += 1
          remaining_xp -= xp_needed
          new_experience = 0
        else
          new_experience += remaining_xp
          remaining_xp = 0
        end
      end

      self.update!(level: new_level, experience: new_experience)
    end

    def add_gold(gold)
      self.update!(gold: self.gold + gold)
    end

    def has_wizardy?
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def set_default_stats!
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def calculate_attack_rate
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def calculate_min_attack
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def calculate_max_attack
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def calculate_min_wizard
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def calculate_max_wizard
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def calculate_defense
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def calculate_defense_rate
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def calculate_health
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def calculate_health_regen
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def calculate_mana
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def calculate_mana_regen
      raise NotImplementedError, "You must implement the method in Player subclass"
    end

    def calculate_max_experience
      # 5 * level * level - 5 * level + 10
      10
    end

    private

    def calculate_params!
      set_default_stats!
      self.max_experience = calculate_max_experience
      self.attack_rate = calculate_attack_rate
      self.min_attack = calculate_min_attack
      self.max_attack = calculate_max_attack
      self.defense_rate = calculate_defense_rate
      self.defense = calculate_defense
      self.max_health = calculate_health
      self.max_mana = calculate_mana
      self.health = max_health
      self.mana = max_mana
    end

    def can_restore?
      last_restore_at < 1.minutes.ago
    end
  end
end
