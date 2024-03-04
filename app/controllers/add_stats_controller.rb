class AddStatsController < ApplicationController
  def new
  end

  def create
    amount = params[:amount].to_i
    stat = params[:stat].to_sym

    unless [:strength, :agility, :vitality, :energy].include?(stat)
      flash.now[:alert] = "You trying to add points to unknown stat."
      return render :new, status: :unprocessable_entity
    end

    unless amount > 0
      flash.now[:alert] = "Amount must be a greater than 0."
      return render :new, status: :unprocessable_entity
    end

    unless amount <= active_character.points
      flash.now[:alert] = "Amount must be a greater than 0 and less than #{ active_character.points }."
      return render :new, status: :unprocessable_entity
    end

    # ToDo
    #points = active_character.points - amount
    #active_character.update(ponts: points, stat => active_character.{stat} + amount)

    redirect_to character_path(active_character), notice: "Added #{ amount } to #{ stat.to_s.capitalize }."
  end
end
