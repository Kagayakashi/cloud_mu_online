class StartsController < ApplicationController
  disallow_authenticated_access
  allow_unauthenticated_access
  allow_unactivated_character_access

  def new
    @character = Characters::Player.new
  end

  def create
    ActiveRecord::Base.transaction do
      user = UserCreatorService.new.call
      ctype = Characters::PlayerRegistry.class_name_for(character_params[:type])
      @character = CharacterCreatorService.new(
        user: user,
        name: character_params[:name],
        type: ctype
      ).call

      unless @character.valid? && @character.persisted?
        raise ActiveRecord::Rollback
      end

      start_new_session_for user
      redirect_to adventure_path and return
    end

    render :new, status: :unprocessable_entity
  end

  def show
  end

  private

  def character_params
    params.require(:characters_character).permit(:name, :type)
  end
end
