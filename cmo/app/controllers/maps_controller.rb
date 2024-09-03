class MapsController < ApplicationController
  before_action :authenticate_user!
  before_action :active_character!

  def show
    @spots = active_character.map.spots
  end
end
