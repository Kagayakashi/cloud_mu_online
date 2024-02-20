class CharactersController < ApplicationController
  def index
    # TODO
  end

  def show
    # TODO
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
    @character = current_user.characters.build(character_params)

    if @character.save
      flash[:success] = "Character created successfully!"
      redirect_to @character
    else
      Rails.logger.error("\nCharacter could not be saved. Database errors: #{@character.errors.full_messages.join(", ")}\n")
      flash.now[:alert] = "Character could not be saved."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :profession)
  end
end
