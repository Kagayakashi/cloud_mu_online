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

lorencia.locations.create! name: "Lumen", code: "lumen"
puts "Created Lorencia npc Lumen"

lorencia.locations.create! name: "Hanzo", code: "hanzo"
puts "Created Lorencia npc Hanzo"

lorencia.locations.create! name: "Pasi", code: "pasi"
puts "Created Lorencia npc Pasi"

map_spiders = lorencia.locations.create! name: "Lorencia spiders", code: "spiders"
puts "Created Lorencia spiders spot"

map_budge_dragons = lorencia.locations.create! name: "Lorencia budge dragons", code: "budge_dragons"
puts "Created Lorencia budge dragons spot"

map_bull_fighters = lorencia.locations.create! name: "Lorencia bull fighters", code: "bull_fighters"
puts "Created Lorencia bull fighters spot"

map_hounds = lorencia.locations.create! name: "Lorencia hounds", code: "hounds"
puts "Created Lorencia hounds spot"

map_elite_bull_fighters =
  lorencia.locations.create! name: "Lorencia elite bull fighters", code: "elite_bull_fighters"
puts "Created Lorencia elite bull fighters spot"

map_lichs = lorencia.locations.create! name: "Lorencia lichs", code: "lichs"
puts "Created Lorencia lichs spot"

map_giants = lorencia.locations.create! name: "Lorencia giants", code: "giants"
puts "Created Lorencia giants spot"

map_skeletons = lorencia.locations.create! name: "Lorencia skeletons", code: "skeletons"
puts "Created Lorencia skeletons spot"

puts "Created monster type Spider"
Characters::Monster.create!(
  name: "Spider",
  level: 1,
  strength: 4,
  agility: 5,
  vitality: 8,
  location: map_spiders,
  map: lorencia,
)

puts "Created monster type Budge Dragon"
Characters::Monster.create!(
  name: "Budge Dragon",
  level: 2,
  strength: 8,
  agility: 10,
  vitality: 16,
  location: map_budge_dragons,
  map: lorencia,
)

puts "Created monster type Bull Fighter"
Characters::Monster.create!(
  name: "Bull Fighter",
  level: 4,
  strength: 14,
  agility: 25,
  vitality: 28,
  location: map_bull_fighters,
  map: lorencia,
)

puts "Created monster type Hound"
Characters::Monster.create!(
  name: "Hound",
  level: 7,
  strength: 25,
  agility: 30,
  vitality: 36,
  location: map_hounds,
  map: lorencia,
)

puts "Created monster type Elite Bull Fighter"
Characters::Monster.create!(
  name: "Elite Bull Fighter",
  level: 11,
  strength: 30,
  agility: 50,
  vitality: 48,
  location: map_elite_bull_fighters,
  map: lorencia,
)

puts "Created monster type Lich"
Characters::Monster.create!(
  name: "Lich",
  level: 15,
  strength: 40,
  agility: 75,
  vitality: 65,
  location: map_lichs,
  map: lorencia,
)

puts "Created monster type Giant"
Characters::Monster.create!(
  name: "Giant",
  level: 18,
  strength: 50,
  agility: 105,
  vitality: 80,
  location: map_giants,
  map: lorencia,
)

puts "Created monster type Skeleton"
Characters::Monster.create!(
  name: "Skeleton",
  level: 20,
  strength: 60,
  agility: 150,
  vitality: 105,
  location: map_skeletons,
  map: lorencia,
)
