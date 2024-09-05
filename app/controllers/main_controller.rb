class MainController < ApplicationController
  before_action :authenticate_user!
  before_action :active_character!

  def index
  end
end
