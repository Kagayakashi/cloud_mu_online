class StartsController < ApplicationController
  before_action :guest_only!
  before_action :create_user, only: [:create]
  before_action :create_character, only: [:create]

  def show
  end

  def new
    @character = Character.new
  end

  def create
    # @character.user = @user
    if @character.valid?
      @user.save
      @character.user
      login(@user)
      @user.create_player(character: @character)
      redirect_to adventure_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def guest_only!
    redirect_to adventure_path if current_user
  end

  def create_user
    current_time = Time.now
    username = "User_#{current_time.strftime('%Y%m%d%H%M%S')}"
    password = SecureRandom.alphanumeric(20)

    @user = User.new(
      username: username,
      email: "#{username}@example.com",
      password: password,
      password_confirmation: password
    )
  end

  def create_character
    character_creator = CharacterCreatorService.new(@user, start_character_params)
    @character = character_creator.call
  end

  def start_character_params
    params.require(:character).permit(:profession, :name)
  end
end
