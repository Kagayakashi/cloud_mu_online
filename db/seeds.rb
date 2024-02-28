# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
SpotMonster.delete_all
Monster.delete_all
Spot.delete_all
Map.delete_all


lorencia = Map.create! :name => "Lorencia", :min_level => 1, :teleport_cost => 0

Spot.create! :name => "Lorencia City", :map => lorencia

lorencia_spider_spot = Spot.create! :name => "Beginner Adventurer's Camp", :map => lorencia

spider = Monster.create!(
  name: "Spider",
  level: 2,
  health: 40,
  min_attack: 6,
  max_attack: 8,
  attack_rate: 8,
  defense: 1,
  defense_rate: 1,
  spawn_time: 60,
)

SpotMonster.create!(monster: spider, spot: lorencia_spider_spot)
