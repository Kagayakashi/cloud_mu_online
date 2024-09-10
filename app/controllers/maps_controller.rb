class MapsController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  def show
    @spots = player.map.spots
  end
end
