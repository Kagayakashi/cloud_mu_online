class CharactersController < ApplicationController
  before_action :authenticate_user!

  def index
    @characters = current_user.characters
  end

  def show
    begin
      @character = current_user.characters.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to characters_path, alert: "Character not found."
    end
  end

  def new
  end

  def create
    character_creator = CharacterCreatorService.new(user: current_user, params: create_character_params)
    @character = character_creator.create
    
    Rails.logger.debug(@character)

    if @character
      redirect_to characters_path, notice: "Character created successfully!"
    else
      flash.now[:alert] = "Failed to create character."
      render :new, status: :unprocessable_entity
    end
  end

  def activate
    character = current_user.characters.find_by(id: params[:id])

    if character.nil?
      return redirect_to characters_path, alert: "Character not found."
    end

    replace_active_character(character)
  rescue ActiveRecord::RecordInvalid
    redirect_to characters_path, alert: "Failed to activate character #{character.name}."
  end

  private

  def replace_active_character(character)
    ActiveRecord::Base.transaction do
      player&.destroy
      player = current_user.build_player(character: character)
      if player.save
        redirect_to characters_path, notice: "Character #{character.name} has been activated."
      else
        raise ActiveRecord::Rollback
      end
    end
  end

  def create_character_params
    params.require(:characters_character).permit(:name, :type)
  end
end
