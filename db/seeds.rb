# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create! :username => "Admin", :email => "admin@example.com", :password => "admin", :password_confirmation => "admin"
puts "Created user with administrator rights"


Profession.create! :name => "Dark Knight", :code => "dk", :level => 1
puts "Created profession Dark Knight"
Profession.create! :name => "Dark Wizard", :code => "dw", :level => 1
puts "Created profession Dark Wizard"
Profession.create! :name => "Fairy Elf", :code => "elf", :level => 1
puts "Created profession Fairy Elf"

lorencia = Map.create! :name => "Lorencia", :min_level => 1, :teleport_cost => 0
puts "Created map Lorencia"

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

puts "Created monster type Spider"

# Spawn spiders
SpotMonster.create!(monster: spider, spot: lorencia_spider_spot)
SpotMonster.create!(monster: spider, spot: lorencia_spider_spot)
SpotMonster.create!(monster: spider, spot: lorencia_spider_spot)
SpotMonster.create!(monster: spider, spot: lorencia_spider_spot)
SpotMonster.create!(monster: spider, spot: lorencia_spider_spot)

puts "Spawned 5 spiders"
