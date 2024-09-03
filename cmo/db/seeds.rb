# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

SpotMonster.delete_all
Monster.delete_all
Spot.delete_all
Map.delete_all

dark_knight = Profession.create! :name => "Dark Knight", :max_level => 150
dark_wizard = Profession.create! :name => "Dark Wizard", :max_level => 150
elf = Profession.create! :name => "Fairy Elf", :max_level => 150

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
  experience: 100,
  spawn_time: 60,
)

# Spawn spiders
SpotMonster.create!(monster: spider, spot: lorencia_spider_spot)
SpotMonster.create!(monster: spider, spot: lorencia_spider_spot)
SpotMonster.create!(monster: spider, spot: lorencia_spider_spot)
SpotMonster.create!(monster: spider, spot: lorencia_spider_spot)
SpotMonster.create!(monster: spider, spot: lorencia_spider_spot)
