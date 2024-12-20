class AddStatsController < ApplicationController
  before_action :are_stats_available, only: [ :strength, :agility, :vitality, :energy ]

  # POST add_strength
  def strength
    increase_stat(:strength)
  end

  # POST add_agility
  def agility
    increase_stat(:agility)
  end

  # POST add_vitality
  def vitality
    increase_stat(:vitality)
  end

  # POST add_energy
  def energy
    increase_stat(:energy)
  end

  private

  def increase_stat(stat)
    if active_character.points > 0
      active_character.update(points: active_character.points - 1, stat => active_character.send(stat) + 1)
      redirect_to character_path(active_character), notice: "#{stat.capitalize} increased."
    else
      redirect_to character_path(active_character), alert: "Not enought stat points."
    end
  end

  def are_stats_available
    if active_character.points.zero?
      redirect_to character_path(active_character), alert: "Not enought stat points."
    end
  end
end
