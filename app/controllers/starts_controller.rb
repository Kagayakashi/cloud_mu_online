class StartsController < ApplicationController
  before_action :guest_only!

  def show
  end

  def new
    @character = Characters::Character.new
  end

  def create
    ActiveRecord::Base.transaction do
      begin
        @user = UserCreatorService.new.call
        @character = CharacterCreatorService.new(
          user: @user,
          name: character_params[:name],
          type: character_params[:type]
        ).call

        if @character.persisted?
          login(@user)
          redirect_to adventure_path and return
        else
          raise ActiveRecord::Rollback
        end
      rescue ActiveRecord::RecordInvalid, ActiveRecord::Rollback
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def character_params
    params.require(:characters_character).permit(:name, :type)
  end
end
