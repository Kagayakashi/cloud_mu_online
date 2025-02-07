class CharactersController < ApplicationController
  allow_unactivated_character_access

  def index
    @characters = Current.user.characters
  end

  def show
    begin
      @character = Current.user.characters.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to characters_path, alert: "Character not found."
    end
  end

  def new
    @character = Characters::Character.new
  end

  def create
    character_creator_service = CharacterCreatorService.new(
      user: Current.user,
      name: character_params[:name],
      type: character_params[:type]
    )

    @character = character_creator_service.call

    if @character.persisted?
      redirect_to characters_path, notice: "Character created successfully."
    else
      flash.now[:alert] = "Failed to create character."
      render :new, status: :unprocessable_entity
    end
  end

  def activate
    Rails.logger.info(Current.user.inspect)
    if character = Current.user.characters.find(params[:id])
      flash[:notice] = "Character #{character.name} has been activated."
      # update_attribute - skip password validation which is defaul in standard update
      Current.user.update_attribute(:character, character)
    end

    redirect_to characters_path
  end

  private

  def character_params
    params.require(:characters_character).permit(:name, :type)
  end
end
