class AddStatsController < ApplicationController
  def new
  end

  def create
    amount = params[:amount].to_i
    stat = params[:stat].to_sym

    unless [:strength, :agility, :vitality, :energy].include?(stat)
      flash.now[:alert] = "You're trying to add points to an unknown stat."
      return render :new, status: :unprocessable_entity
    end

    unless amount > 0
      flash.now[:alert] = "Amount must be greater than 0."
      return render :new, status: :unprocessable_entity
    end

    unless amount <= active_character.points
      flash.now[:alert] = "Amount must be greater than 0 and less than #{ active_character.points }."
      return render :new, status: :unprocessable_entity
    end


    points_left = active_character.points - amount
    stats_new = active_character[stat] + amount

    active_character.update(points: points_left, stat => stats_new)

    redirect_to character_path(active_character), notice: "Added #{ amount } to #{ stat.to_s.capitalize }."
  end
end
