class HuntingController < ApplicationController
  def index
    @monsters = Current.character.city.monsters
  end

  def show
    begin
      @monster = Characters::Monster.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to hunting_index_path, alert: "Monster not found."
    end
  end
end
