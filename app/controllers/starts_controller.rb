class StartsController < ApplicationController
  before_action :guest_only!

  def show
  end

  def new
    @character = Characters::Character.new
  end

  def create
    ActiveRecord::Base.transaction do
      initialize_user

      character_creator = CharacterCreatorService.new(user: @user, params: character_params)
      @character = character_creator.create

      if @character.persisted?
        login(@user)
        @user.create_player(character: @character)
        redirect_to adventure_path and return
      else
        raise ActiveRecord::Rollback
      end
    end

    render :new, status: :unprocessable_entity
  end

  private

  def guest_only!
    redirect_to adventure_path if current_user
  end

  def initialize_user
    password = SecureRandom.alphanumeric(20)
    @user = User.create!(
      username: generate_unique_username,
      email: "#{generate_unique_username}@example.com",
      password: password,
      password_confirmation: password
    )
  end

  def generate_unique_username
    "User_#{Time.now.strftime('%Y%m%d%H%M%S')}"
  end

  def character_params
    params.require(:characters_character).permit(:name, :type)
  end
end
