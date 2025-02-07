class ApplicationController < ActionController::Base
  include Authentication
  include ActiveCharacter

  # before_action :restore_activity, if: :Current.character
  # before_action :regenerate, if: :Current.character

  # private

  # def regenerate
  #   Current.character.regenerate
  # end

  # def restore_activity
  #   Current.character.restore
  # end
end
