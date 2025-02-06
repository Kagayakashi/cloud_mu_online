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
Characters::Character.destroy_all
User.destroy_all
MapConnection.destroy_all
Map.destroy_all

puts "Database records cleared"

# Users
puts "Created user with administrator rights"
User.create! username: "Admin", email: "admin@example.com", password: "admin", password_confirmation: "admin", is_guest: false

# Maps
map_lorencia = Map.create! name: "Lorencia city", min_level: 1, peace: true
puts "Created Lorencia city"

map_spiders = Map.create! name: "Lorencia spiders", min_level: 1, peace: false
puts "Created Lorencia spiders spot"

map_budge_dragons = Map.create! name: "Lorencia budge dragons", min_level: 1, peace: false
puts "Created Lorencia budge dragons spot"

map_bull_fighters = Map.create! name: "Lorencia bull fighters", min_level: 1, peace: false
puts "Created Lorencia bull fighters spot"

map_hounds = Map.create! name: "Lorencia hounds", min_level: 1, peace: false
puts "Created Lorencia hounds spot"

map_elite_bull_fighters = Map.create! name: "Lorencia elite bull fighters", min_level: 1, peace: false
puts "Created Lorencia elite bull fighters spot"

map_lichs = Map.create! name: "Lorencia lichs", min_level: 1, peace: false
puts "Created Lorencia lichs spot"

map_giants = Map.create! name: "Lorencia giants", min_level: 1, peace: false
puts "Created Lorencia giants spot"

map_skeletons = Map.create! name: "Lorencia skeletons", min_level: 1, peace: false
puts "Created Lorencia skeletons spot"

# Maps connections
MapConnection.create(map: map_lorencia, connected_map: map_spiders)
MapConnection.create(map: map_lorencia, connected_map: map_budge_dragons)
MapConnection.create(map: map_lorencia, connected_map: map_bull_fighters)
MapConnection.create(map: map_lorencia, connected_map: map_elite_bull_fighters)
MapConnection.create(map: map_lorencia, connected_map: map_hounds)
MapConnection.create(map: map_lorencia, connected_map: map_giants)
MapConnection.create(map: map_lorencia, connected_map: map_lichs)
MapConnection.create(map: map_lorencia, connected_map: map_skeletons)
puts "Maps connected"

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
  map: map_spiders,
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
  map: map_budge_dragons,
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
  map: map_bull_fighters,
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
  map: map_hounds,
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
  map: map_elite_bull_fighters,
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
  map: map_lichs,
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
  map: map_giants,
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
  map: map_skeletons,
)
