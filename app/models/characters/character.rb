module Characters
  class Character < ApplicationRecord
    belongs_to :user
    belongs_to :profession
    belongs_to :map
    has_many :game_logs, class_name: "GameLogs::GameLog"

    validates :name, presence: true, uniqueness: true
    validates :name, length: { minimum: 4, maximum: 20 }
    validates :type, presence: true

    def self.order
      raise NotImplementedError, "You must implement the method in Character subclass"
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

    def has_wizardy?
      raise NotImplementedError, "You must implement the method in Character subclass"
    end

    def set_default_stats!
      raise NotImplementedError, "You must implement the method in Character subclass"
    end

    def calculate_attack_rate
      raise NotImplementedError, "You must implement the method in Character subclass"
    end

    def calculate_min_attack
      raise NotImplementedError, "You must implement the method in Character subclass"
    end

    def calculate_max_attack
      raise NotImplementedError, "You must implement the method in Character subclass"
    end

    def calculate_min_wizard
      raise NotImplementedError, "You must implement the method in Character subclass"
    end

    def calculate_max_wizard
      raise NotImplementedError, "You must implement the method in Character subclass"
    end

    def calculate_defense
      raise NotImplementedError, "You must implement the method in Character subclass"
    end

    def calculate_defense_rate
      raise NotImplementedError, "You must implement the method in Character subclass"
    end

    def calculate_health
      raise NotImplementedError, "You must implement the method in Character subclass"
    end

    def calculate_health_regen
      raise NotImplementedError, "You must implement the method in Character subclass"
    end

    def calculate_mana
      raise NotImplementedError, "You must implement the method in Character subclass"
    end

    def calculate_mana_regen
      raise NotImplementedError, "You must implement the method in Character subclass"
    end

    def add_experience_from_monster!(monster)
      experience = (monster.level.to_f / self.level * monster.experience).floor
      gold = experience
      self.gold += gold
      self.experience += experience
      add_level
      self.save
      experience
    end

    def max_experience
      (self.level * self.level) * (self.level + 9) * 2
    end

    def add_level
      if experience >= max_experience
        self.experience = 0
        self.level += 1
        self.points += 5

        self.max_health = calculate_health
        self.max_mana = calculate_mana

        self.current_health = max_health
        self.current_mana = max_mana
      end
    end

    def can_restore?
      # Todo switch into 1 hour
      last_restore_at < 1.minutes.ago
    end

    def restore
      self.update(last_restore_at: Time.current, activity: 100)
    end

    def set_default_values
      set_default_stats!

      self.level = 1
      self.experience = 0
      self.points = 0
      self.activity = 100
      self.gold = 0
      self.last_restore_at = Time.current

      self.max_health = calculate_health
      self.max_mana = calculate_mana

      self.current_health ||= max_health
      self.current_mana ||= max_mana
      self.map = Map.first
    end
  end
end
