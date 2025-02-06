class HuntingController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  def index
    @spots = active_character.map.locations.spots
  end

  def show
    @spot = active_character.map.locations.spots.find(params[:id])
    return redirect_to hunting_path, alert: "Invalid spot" unless @spot

    @monster = @spot.monsters.order("RANDOM()").first
  end
end
