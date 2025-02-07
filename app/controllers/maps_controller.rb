class MapsController < ApplicationController
  def show
    @spots = Current.character.map.spots
  end
end
