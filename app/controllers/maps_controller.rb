class MapsController < ApplicationController
  def show
    @spots = active_character.map.spots
  end
end
