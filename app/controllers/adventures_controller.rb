class AdventuresController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  def show
    @map = player.map
    @paths = @map.connected_maps
  end

  def travel
    map = Map.find(params[:id])
    player.map = map
    if player.save
      redirect_to adventure_path
    end
  end
end
