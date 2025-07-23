module Characters
  class PlayerRegistry
    MAPPING = {
      "darkknight" => "Characters::DarkKnight",
      "darkwizard" => "Characters::DarkWizard",
      "fairyelf" => "Characters::FairyElf"
    }.freeze

    REVERSE_MAPPING = MAPPING.invert.freeze

    def self.all
      MAPPING
    end

    def self.valid_keys
      MAPPING.keys
    end

    def self.class_name_for(key)
      MAPPING[key]
    end

    def self.key_for_class(class_name)
      REVERSE_MAPPING[class_name]
    end

    def self.options_for_select
      MAPPING.map { |key, class_name| [ human_name_for(key), key ] }
    end

    def self.human_name_for(input)
      key =
        if valid_keys.include?(input)
          input
        elsif key = key_for_class(input)
          key
        else
          nil
        end

      key = input unless key

      I18n.t("characters.#{key}")
    end

    def self.human_name_for(key)
      I18n.t("characters.#{key}")
    end
  end
end
