# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

GameLogs::GameLog.destroy_all
Characters::Player.destroy_all
Characters::Monster.destroy_all
Location.destroy_all
Map.destroy_all
Session.destroy_all
User.destroy_all

puts "Database records cleared"

# Users
puts "Created user with administrator rights"
User.create! username: "Admin", email: "admin@example.com", password: "admin", password_confirmation: "admin", is_guest: false

# Maps
lorencia = Map.create! name: "maps.lorencia", code: "lorencia", level: 1
puts "Created Lorencia city"

lorencia.locations.create! name: "Lumen", code: "lumen", peace: true
puts "Created Lorencia npc Lumen"

lorencia.locations.create! name: "Hanzo", code: "hanzo", peace: true
puts "Created Lorencia npc Hanzo"

lorencia.locations.create! name: "Pasi", code: "pasi", peace: true
puts "Created Lorencia npc Pasi"

map_spiders = lorencia.locations.create! name: "Lorencia spiders", code: "spiders", peace: false
puts "Created Lorencia spiders spot"

map_budge_dragons = lorencia.locations.create! name: "Lorencia budge dragons", code: "budge_dragons", peace: false
puts "Created Lorencia budge dragons spot"

map_bull_fighters = lorencia.locations.create! name: "Lorencia bull fighters", code: "bull_fighters", peace: false
puts "Created Lorencia bull fighters spot"

map_hounds = lorencia.locations.create! name: "Lorencia hounds", code: "hounds", peace: false
puts "Created Lorencia hounds spot"

map_elite_bull_fighters =
  lorencia.locations.create! name: "Lorencia elite bull fighters", code: "elite_bull_fighters", peace: false
puts "Created Lorencia elite bull fighters spot"

map_lichs = lorencia.locations.create! name: "Lorencia lichs", code: "lichs", peace: false
puts "Created Lorencia lichs spot"

map_giants = lorencia.locations.create! name: "Lorencia giants", code: "giants", peace: false
puts "Created Lorencia giants spot"

map_skeletons = lorencia.locations.create! name: "Lorencia skeletons", code: "skeletons", peace: false
puts "Created Lorencia skeletons spot"

puts "Created monster type Spider"
Characters::Monster.create!(
  name: "Spider",
  level: 2,
  health: 40,
  min_attack: 6,
  max_attack: 8,
  attack_rate: 8,
  defense: 1,
  defense_rate: 1,
  location: map_spiders,
  map: lorencia,
)

puts "Created monster type Budge Dragon"
Characters::Monster.create!(
  name: "Budge Dragon",
  level: 4,
  health: 80,
  min_attack: 12,
  max_attack: 17,
  attack_rate: 18,
  defense: 3,
  defense_rate: 3,
  location: map_budge_dragons,
  map: lorencia,
)

puts "Created monster type Bull Fighter"
Characters::Monster.create!(
  name: "Bull Fighter",
  level: 6,
  health: 120,
  min_attack: 19,
  max_attack: 26,
  attack_rate: 28,
  defense: 6,
  defense_rate: 6,
  location: map_bull_fighters,
  map: lorencia,
)

puts "Created monster type Hound"
Characters::Monster.create!(
  name: "Hound",
  level: 9,
  health: 160,
  min_attack: 25,
  max_attack: 35,
  attack_rate: 35,
  defense: 9,
  defense_rate: 9,
  location: map_hounds,
  map: lorencia,
)

puts "Created monster type Elite Bull Fighter"
Characters::Monster.create!(
  name: "Elite Bull Fighter",
  level: 12,
  health: 220,
  min_attack: 35,
  max_attack: 44,
  attack_rate: 50,
  defense: 12,
  defense_rate: 12,
  location: map_elite_bull_fighters,
  map: lorencia,
)

puts "Created monster type Lich"
Characters::Monster.create!(
  name: "Lich",
  level: 14,
  health: 260,
  min_attack: 45,
  max_attack: 52,
  attack_rate: 62,
  defense: 15,
  defense_rate: 15,
  location: map_lichs,
  map: lorencia,
)

puts "Created monster type Giant"
Characters::Monster.create!(
  name: "Giant",
  level: 17,
  health: 400,
  min_attack: 57,
  max_attack: 62,
  attack_rate: 80,
  defense: 18,
  defense_rate: 18,
  location: map_giants,
  map: lorencia,
)

puts "Created monster type Skeleton"
Characters::Monster.create!(
  name: "Skeleton",
  level: 19,
  health: 525,
  min_attack: 68,
  max_attack: 74,
  attack_rate: 93,
  defense: 21,
  defense_rate: 21,
  location: map_skeletons,
  map: lorencia,
)
