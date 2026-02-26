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
City.destroy_all
Session.destroy_all
User.destroy_all

# Users
User.create!(
  username: "Admin",
  email: "admin@example.com",
  password: "admin",
  password_confirmation: "admin",
  is_guest: false
)


lorencia = City.create! name: "Lorencia", level: 1

lorencia.locations.create! name: "Tavern"
lorencia.locations.create! name: "Blacksmith"
lorencia.locations.create! name: "Mage shop"

Characters::Monster.create!(
  name: "Spider",
  level: 1,
  strength: 4,
  agility: 5,
  vitality: 8,
  city: lorencia,
)

Characters::Monster.create!(
  name: "Budge Dragon",
  level: 2,
  strength: 8,
  agility: 10,
  vitality: 16,
  city: lorencia,
)

Characters::Monster.create!(
  name: "Bull Fighter",
  level: 4,
  strength: 14,
  agility: 25,
  vitality: 28,
  city: lorencia,
)

Characters::Monster.create!(
  name: "Hound",
  level: 7,
  strength: 25,
  agility: 30,
  vitality: 36,
  city: lorencia,
)

Characters::Monster.create!(
  name: "Elite Bull Fighter",
  level: 11,
  strength: 30,
  agility: 50,
  vitality: 48,
  city: lorencia,
)

Characters::Monster.create!(
  name: "Lich",
  level: 15,
  strength: 40,
  agility: 75,
  vitality: 65,
  city: lorencia,
)

Characters::Monster.create!(
  name: "Giant",
  level: 18,
  strength: 50,
  agility: 105,
  vitality: 80,
  city: lorencia,
)

Characters::Monster.create!(
  name: "Skeleton",
  level: 20,
  strength: 60,
  agility: 150,
  vitality: 105,
  city: lorencia,
)
