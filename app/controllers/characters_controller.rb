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
    @character = Character.new(character_params_with_profession)
    @character.set_default_values
    @character.user = current_user
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
        redirect_to characters_path, alert: "Failed to change active character to #{ character.name }."
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to characters_path, alert: "Cannot activate character that is not found."
    end
  end

  private
  def character_params_with_profession
    params_with_profession = create_character_params
    profession = Profession.find_by(code: params_with_profession[:profession])
  
    unless profession
      flash.now[:alert] = "Failed to create character without profession."
      render :new, status: :unprocessable_entity
      return
    end
  
    params_with_profession[:profession] = profession
    params_with_profession
  end


  def create_character_params
    params.require(:character).permit(:name, :profession)
  end
end
