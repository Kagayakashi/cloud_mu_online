# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_05_121501) do
  create_table "characters", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "level", null: false
    t.integer "experience", null: false
    t.integer "points", null: false
    t.integer "current_health", null: false
    t.integer "max_health", null: false
    t.integer "current_mana", null: false
    t.integer "max_mana", null: false
    t.integer "strength", null: false
    t.integer "agility", null: false
    t.integer "vitality", null: false
    t.integer "energy", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "map_id", null: false
    t.bigint "profession_id", null: false
    t.index ["map_id"], name: "index_characters_on_map_id"
    t.index ["profession_id"], name: "index_characters_on_profession_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "maps", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "min_level", null: false
    t.integer "teleport_cost", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monsters", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "level", null: false
    t.integer "health", null: false
    t.integer "min_attack", null: false
    t.integer "max_attack", null: false
    t.integer "attack_rate", null: false
    t.integer "defense_rate", null: false
    t.integer "defense", null: false
    t.integer "experience", null: false
    t.integer "spawn_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_players_on_character_id"
    t.index ["user_id"], name: "unique_users", unique: true
  end

  create_table "professions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spot_monsters", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "health", null: false
    t.bigint "monster_id", null: false
    t.bigint "spot_id", null: false
    t.bigint "target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monster_id"], name: "index_spot_monsters_on_monster_id"
    t.index ["spot_id"], name: "index_spot_monsters_on_spot_id"
    t.index ["target_id"], name: "index_spot_monsters_on_target_id"
  end

  create_table "spots", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "map_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["map_id"], name: "index_spots_on_map_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "characters", "maps"
  add_foreign_key "characters", "professions"
  add_foreign_key "characters", "users"
  add_foreign_key "players", "characters"
  add_foreign_key "players", "users"
  add_foreign_key "spot_monsters", "characters", column: "target_id"
  add_foreign_key "spot_monsters", "monsters"
  add_foreign_key "spot_monsters", "spots"
  add_foreign_key "spots", "maps"
end
