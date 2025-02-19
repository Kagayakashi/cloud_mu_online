class StartsController < ApplicationController
  disallow_authenticated_access
  allow_unauthenticated_access
  allow_unactivated_character_access

  def new
    @character = Characters::Player.new
  end

  def create
    ActiveRecord::Base.transaction do
      begin
        user = UserCreatorService.new.call
        @character = CharacterCreatorService.new(
          user: user,
          name: character_params[:name],
          type: character_params[:type]
        ).call

        if @character.persisted?
          start_new_session_for user
          redirect_to adventure_path and return
        else
          raise ActiveRecord::Rollback
        end
      rescue ActiveRecord::RecordInvalid, ActiveRecord::Rollback
        render :new, status: :unprocessable_entity
      end
    end
  end

  def show
  end

  private

  def character_params
    params.require(:characters_character).permit(:name, :type)
  end
end
