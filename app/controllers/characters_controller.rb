class CharactersController < ApplicationController
  def index
  end

  def new
    @character = Character.new
  end

  def create
    character_class = Character.TYPES[params[:character][:character_type]]
    @character = character_class.create(character_params) if character_class
  end

  private

  def character_params
    params.require(:character).permit(:name, :character_type)
  end
end
