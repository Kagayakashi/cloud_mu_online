# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

InGameLog.destroy_all
Monster.destroy_all
MonsterType.destroy_all
Player.destroy_all
Character.destroy_all
Profession.destroy_all
User.destroy_all
MapConnection.destroy_all
Map.destroy_all

puts "Database records cleared"


# Users
User.create! :username => "Admin", :email => "admin@example.com", :password => "admin", :password_confirmation => "admin", is_guest: false
puts "Created user with administrator rights"

# Classes for characters
Profession.create! :name => "Dark Knight", :code => "dk", :level => 1
puts "Created profession Dark Knight"
Profession.create! :name => "Dark Wizard", :code => "dw", :level => 1
puts "Created profession Dark Wizard"
Profession.create! :name => "Fairy Elf", :code => "elf", :level => 1
puts "Created profession Fairy Elf"

# Maps
map_lorencia = Map.create! :name => "Lorencia city", :min_level => 1, :can_teleport => true, :teleport_cost => 1000, :teleport_min_level => 10
puts "Created Lorencia city"

map_spiders = Map.create! :name => "Lorencia spiders", :min_level => 1
puts "Created Lorencia spiders spot"

map_budge_dragons = Map.create! :name => "Lorencia budge dragons", :min_level => 1
puts "Created Lorencia budge dragons spot"

map_bull_fighters = Map.create! :name => "Lorencia bull fighters", :min_level => 1
puts "Created Lorencia bull fighters spot"

map_hounds = Map.create! :name => "Lorencia hounds", :min_level => 1
puts "Created Lorencia hounds spot"

map_elite_bull_fighters = Map.create! :name => "Lorencia elite bull fighters", :min_level => 1
puts "Created Lorencia elite bull fighters spot"

map_lichs = Map.create! :name => "Lorencia lichs", :min_level => 1
puts "Created Lorencia lichs spot"

map_giants = Map.create! :name => "Lorencia giants", :min_level => 1
puts "Created Lorencia giants spot"

map_skeletons = Map.create! :name => "Lorencia skeletons", :min_level => 1
puts "Created Lorencia skeletons spot"

# Maps connections
MapConnection.create(map: map_lorencia, connected_map: map_spiders)
MapConnection.create(map: map_lorencia, connected_map: map_bull_fighters)
MapConnection.create(map: map_lorencia, connected_map: map_hounds)
MapConnection.create(map: map_lorencia, connected_map: map_lichs)

MapConnection.create(map: map_spiders, connected_map: map_lorencia)
MapConnection.create(map: map_spiders, connected_map: map_budge_dragons)

MapConnection.create(map: map_budge_dragons, connected_map: map_spiders)

MapConnection.create(map: map_bull_fighters, connected_map: map_lorencia)

MapConnection.create(map: map_hounds, connected_map: map_lorencia)
MapConnection.create(map: map_hounds, connected_map: map_elite_bull_fighters)
MapConnection.create(map: map_hounds, connected_map: map_giants)

MapConnection.create(map: map_elite_bull_fighters, connected_map: map_hounds)

MapConnection.create(map: map_giants, connected_map: map_hounds)

MapConnection.create(map: map_lichs, connected_map: map_lorencia)
MapConnection.create(map: map_lichs, connected_map: map_skeletons)

MapConnection.create(map: map_skeletons, connected_map: map_lichs)

puts "Maps connected"

spider = MonsterType.create!(
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
  map: map_spiders,
)

puts "Created monster type Spider"

5.times { spider.monsters.create }
puts "Spawned 5 Spiders"

budge_dragon = MonsterType.create!(
  name: "Budge Dragon",
  level: 4,
  health: 80,
  min_attack: 12,
  max_attack: 17,
  attack_rate: 18,
  defense: 3,
  defense_rate: 3,
  experience: 200,
  spawn_time: 60,
  map: map_budge_dragons,
)

puts "Created monster type Budge Dragon"

5.times { budge_dragon.monsters.create }
puts "Spawned 5 Budge Dragons"

bull_fighter = MonsterType.create!(
  name: "Bull Fighter",
  level: 6,
  health: 120,
  min_attack: 19,
  max_attack: 26,
  attack_rate: 28,
  defense: 6,
  defense_rate: 6,
  experience: 300,
  spawn_time: 60,
  map: map_bull_fighters,
)

puts "Created monster type Bull Fighter"

5.times { bull_fighter.monsters.create }
puts "Spawned 5 Bull Fighters"

hound = MonsterType.create!(
  name: "Hound",
  level: 9,
  health: 160,
  min_attack: 25,
  max_attack: 35,
  attack_rate: 35,
  defense: 9,
  defense_rate: 9,
  experience: 400,
  spawn_time: 60,
  map: map_hounds,
)

puts "Created monster type Hound"

5.times { hound.monsters.create }
puts "Spawned 5 Hounds"

elite_bull_fighter = MonsterType.create!(
  name: "Elite Bull Fighter",
  level: 12,
  health: 220,
  min_attack: 35,
  max_attack: 44,
  attack_rate: 50,
  defense: 12,
  defense_rate: 12,
  experience: 500,
  spawn_time: 60,
  map: map_elite_bull_fighters,
)

puts "Created monster type Elite Bull Fighter"

5.times { elite_bull_fighter.monsters.create }
puts "Spawned 5 Elite Bull Fighters"

lich = MonsterType.create!(
  name: "Lich",
  level: 14,
  health: 260,
  min_attack: 45,
  max_attack: 52,
  attack_rate: 62,
  defense: 15,
  defense_rate: 15,
  experience: 600,
  spawn_time: 60,
  map: map_lichs,
)

puts "Created monster type Lich"

5.times { lich.monsters.create }
puts "Spawned 5 Lichs"

giant = MonsterType.create!(
  name: "Giant",
  level: 17,
  health: 400,
  min_attack: 57,
  max_attack: 62,
  attack_rate: 80,
  defense: 18,
  defense_rate: 18,
  experience: 700,
  spawn_time: 60,
  map: map_giants,
)

puts "Created monster type Giant"

5.times { giant.monsters.create }
puts "Spawned 5 Giants"

skeleton = MonsterType.create!(
  name: "Skeleton",
  level: 19,
  health: 525,
  min_attack: 68,
  max_attack: 74,
  attack_rate: 93,
  defense: 21,
  defense_rate: 21,
  experience: 800,
  spawn_time: 60,
  map: map_skeletons,
)

puts "Created monster type Skeleton"

5.times { map_skeletons.monsters.create }
puts "Spawned 5 Skeletons"
