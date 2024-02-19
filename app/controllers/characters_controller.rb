class CharactersController < ApplicationController
  def index
  end

  def new
    @character = Character.new
  end

  def create
    service = CharacterCreationService.new(
      name: character_params[:name],
      type: character_params[:character_type]
    )

    character_type = service.call

    if character_type && character_type.valid?
      character = current_user.characters.build(characterable: character_type)

      if character.save
        flash[:success] = "Character created successfully!"
        redirect_to character
      else
        flash.now[:error] = "Character could not be saved."
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:error] = "Invalid character type."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :character_type)
  end
end
