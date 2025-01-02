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
    @character = Characters::Character.new
  end

  def create
    character_creator_service = CharacterCreatorService.new(
      user: current_user,
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

  def character_params
    params.require(:characters_character).permit(:name, :type)
  end
end
