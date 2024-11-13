class ApplicationController < ActionController::Base
  before_action :restore_activity, if: :active_character
  before_action :regenerate, if: :active_character

  private

  def regenerate
    active_character.regenerate
  end

  def restore_activity
    active_character.restore
  end

  def activate_character!
    redirect_to characters_path, alert: "You must have active character to do that." unless player
  end

  def authenticate_user!
    redirect_to start_path unless user_signed_in?
  end

  def guest_only!
    redirect_to adventure_path if user_signed_in?
  end

  def current_user
    Current.user ||= authenticate_user_from_session
  end

  helper_method :current_user

  def player
    current_user&.player
  end

  helper_method :player

  def active_character
    player&.character
  end

  helper_method :active_character

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end

  helper_method :user_signed_in?

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
    user.update_last_login_time
  end

  def logout(user)
    Current.user = nil
    reset_session
  end
end
