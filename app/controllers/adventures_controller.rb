class AdventuresController < ApplicationController
  before_action :authenticate_user!
  before_action :activate_character!

  def show
  end
end
