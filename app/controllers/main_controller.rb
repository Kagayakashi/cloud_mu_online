class MainController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  def index
  end
end
