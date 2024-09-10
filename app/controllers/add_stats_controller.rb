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

    unless amount <= player.points
      flash.now[:alert] = "Amount must be greater than 0 and less than #{ player.points }."
      return render :new, status: :unprocessable_entity
    end


    points_left = player.points - amount
    stats_new = player[stat] + amount

    player.update(points: points_left, stat => stats_new)

    redirect_to character_path(player), notice: "Added #{ amount } to #{ stat.to_s.capitalize }."
  end
end
