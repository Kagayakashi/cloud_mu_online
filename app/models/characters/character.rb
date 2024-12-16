module Characters
  # Base class for all character types. Do not use directly.
  # Use the subclasses like DarkKnight or DarkWizard instead.
  class Character < ApplicationRecord
    before_validation :set_default_values, if: :new_record?

    belongs_to :user
    belongs_to :profession
    belongs_to :map
    has_many :game_logs, class_name: "GameLogs::GameLog"

    validates :name, presence: true, uniqueness: true, length: { in: 4..20 }
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
      while experience >= max_experience do
        self.experience -= max_experience
        self.level += 1
        self.points += 5

        self.max_health = calculate_health
        self.max_mana = calculate_mana

        self.current_health = max_health
        self.current_mana = max_mana
      end

      level
    end

    def restore
      return unless can_restore?

      self.update(last_restore_at: Time.current, activity: 100)
    end

    def regenerate
      return unless can_regenerate?

      health = current_health + calculate_health_regen
      if health > max_health
        health = max_health
      end

      mana = current_mana + calculate_mana_regen
      if mana > max_mana
        mana = max_mana
      end

      self.update(
        last_regeneration_at: Time.current,
        current_health: health,
        current_mana: mana,
      )
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

    private

    def set_default_values
      today = Time.current
      set_default_stats!

      self.level = 1
      self.experience = 0
      self.points = 0
      self.activity = 100
      self.gold = 0
      self.last_restore_at = today
      self.last_regeneration_at = today

      self.max_health = calculate_health
      self.max_mana = calculate_mana

      self.current_health ||= max_health
      self.current_mana ||= max_mana
      self.map = Map.first
    end

    def can_restore?
      # Todo switch into 1 hour
      last_restore_at < 1.minutes.ago
    end

    def can_regenerate?
      (current_health < max_health || current_mana < max_mana) &&
      (last_regeneration_at.nil? || last_regeneration_at < 1.minute.ago)
    end
  end
end
