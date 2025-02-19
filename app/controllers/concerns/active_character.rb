module ActiveCharacter
  extend ActiveSupport::Concern

  included do
    before_action :require_active_character
    helper_method :active_character?
  end

  class_methods do
    def allow_unactivated_character_access(**options)
      skip_before_action :require_active_character, **options
    end
  end

  private
    def active_character?
      Current.character
    end

    def require_active_character
      Current.character || request_activate_character
    end

    def request_activate_character
      redirect_to characters_path
    end
end
