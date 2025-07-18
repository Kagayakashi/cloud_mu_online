class RegistrationsController < ApplicationController
  before_action :only_for_guest

  def new
    @user = User.new
  end

  def create
    @user = Current.user
    @user.assign_attributes(registration_params)

    @user.is_guest = false
    if @user.save
      redirect_to settings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def only_for_guest
    redirect_to adventure_path unless Current.user.is_guest
  end

  def registration_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
