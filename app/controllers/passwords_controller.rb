class PasswordsController < ApplicationController
  allow_unactivated_character_access

  def edit
  end

  def update
    if Current.user.update(password_params)
      redirect_to settings_path, notice: "Your password has been updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(
      :password,
      :password_confirmation,
      :password_challenge
    ).with_defaults(password_challenge: "")
  end
end
