class CharactersController < ApplicationController
  before_action :authenticate_user!

  def index
    @characters = current_user.characters
  end

  def show
    begin
      @character = current_user.characters.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to :index, alert: "Character not found."
    end
  end

  def edit
    # TODO
  end

  def update
    # TODO
  end

  def new
    @character = Character.new
  end

  def create
    @character = current_user.characters.build(create_character_params)
    logger.debug(@character)
    if @character.save
      redirect_to characters_path, notice: "Character created successfully!"
    else
      flash.now[:alert] = "Character could not be saved."
      render :new, status: :unprocessable_entity
    end
  end

  def activate
    begin
      character = current_user.characters.find(params[:id])
      current_user.active_character = character
      if current_user.save
        redirect_to characters_path, notice: "Character #{ character.name } has been activated."
      else
        redirect_to :back, alert: "Character could not be activated."
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to :back, alert: "Cannot activate character that is not found."
    end
  end

  private

  def create_character_params
    params.require(:character).permit(:name, :profession)
  end
end
