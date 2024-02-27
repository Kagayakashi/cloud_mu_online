class MapsController < ApplicationController
  before_action :authenticate_user!

  def show
    @spots = active_character.map.spots
  end
end
