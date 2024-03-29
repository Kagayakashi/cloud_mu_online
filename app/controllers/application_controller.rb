class ApplicationController < ActionController::Base
  private

  def active_character!
    redirect_to characters_path, alert: "You must have active character to do that." unless active_character
  end

  def authenticate_user!
    redirect_to new_session_path, alert: "You must be logged in to do that." unless user_signed_in?
  end

  def current_user
    Current.user ||= authenticate_user_from_session
  end

  helper_method :current_user

  def active_character
    current_user.active_character
  end

  helper_method :active_character

  def active_character_map
    active_character.map
  end

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
  end

  def logout(user)
    Current.user = nil
    reset_session
  end
end
