class RegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  def new
    @user = User.new
  end

  def create
    @user = current_user
    @user.assign_attributes(registration_params)
    @user.is_guest = false
    if @user.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
