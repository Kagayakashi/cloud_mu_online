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

    if @character.save
      redirect_to characters_path, notice: "Character created successfully!"
    else
      flash.now[:alert] = "Character could not be saved."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def create_character_params
    params.require(:character).permit(:name, :profession)
  end
end
