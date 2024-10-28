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

  def edit
    # TODO
  end

  def update
    # TODO
  end

  def new
    @character = Characters::Character.new
  end

  def create
    @character = Characters::Character.new(create_character_params)
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
    params.require(:character).permit(:name, :character_type)
  end
end
