class HuntingController < ApplicationController
  def index
    @spots = Current.character.map.locations.spots
  end

  def show
    @spot = Current.character.map.locations.spots.find(params[:id])
    return redirect_to hunting_path, alert: "Invalid spot" unless @spot

    @monster = @spot.monsters.order("RANDOM()").first
  end
end
