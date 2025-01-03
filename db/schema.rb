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

ActiveRecord::Schema[8.0].define(version: 2024_09_18_142256) do
  create_table "characters", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.integer "level", null: false
    t.integer "experience", null: false
    t.integer "max_experience", null: false
    t.integer "points", null: false
    t.integer "health", null: false
    t.integer "max_health", null: false
    t.integer "mana", null: false
    t.integer "max_mana", null: false
    t.integer "strength", null: false
    t.integer "agility", null: false
    t.integer "vitality", null: false
    t.integer "energy", null: false
    t.integer "attack_rate", null: false
    t.integer "min_attack", null: false
    t.integer "max_attack", null: false
    t.integer "defense_rate", null: false
    t.integer "defense", null: false
    t.integer "gold", null: false
    t.integer "activity", null: false
    t.datetime "last_restore_at", null: false
    t.datetime "last_regeneration_at", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "map_id", null: false
    t.integer "profession_id", null: false
    t.index ["map_id"], name: "index_characters_on_map_id"
    t.index ["name"], name: "unique_character_name", unique: true
    t.index ["profession_id"], name: "index_characters_on_profession_id"
    t.index ["type"], name: "index_characters_on_type"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "game_logs", force: :cascade do |t|
    t.integer "character_id", null: false
    t.text "description"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_game_logs_on_character_id"
  end

  create_table "map_connections", force: :cascade do |t|
    t.integer "map_id", null: false
    t.integer "connected_map_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["connected_map_id"], name: "index_map_connections_on_connected_map_id"
    t.index ["map_id", "connected_map_id"], name: "index_map_connections_on_map_id_and_connected_map_id", unique: true
    t.index ["map_id"], name: "index_map_connections_on_map_id"
  end

  create_table "maps", force: :cascade do |t|
    t.string "code"
    t.string "name", null: false
    t.integer "min_level", default: 1, null: false
    t.boolean "can_teleport", default: false, null: false
    t.integer "teleport_cost", default: 1000, null: false
    t.integer "teleport_min_level", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "unique_map_code", unique: true
    t.index ["name"], name: "unique_map_name", unique: true
  end

  create_table "monster_types", force: :cascade do |t|
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
    t.integer "map_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["map_id"], name: "index_monster_types_on_map_id"
    t.index ["name"], name: "unique_monster_name", unique: true
  end

  create_table "monsters", force: :cascade do |t|
    t.string "type"
    t.integer "health", null: false
    t.boolean "dead", default: false, null: false
    t.datetime "dead_at"
    t.integer "monster_type_id", null: false
    t.integer "target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monster_type_id"], name: "index_monsters_on_monster_type_id"
    t.index ["target_id"], name: "index_monsters_on_target_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "unique_player_character", unique: true
    t.index ["user_id"], name: "unique_player_user", unique: true
  end

  create_table "professions", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "unique_profession_code", unique: true
    t.index ["name"], name: "unique_profession_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "last_login_at"
    t.boolean "is_guest", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "unique_user_email", unique: true
    t.index ["username"], name: "unique_user_username", unique: true
  end

  add_foreign_key "characters", "maps"
  add_foreign_key "characters", "professions"
  add_foreign_key "characters", "users"
  add_foreign_key "game_logs", "characters"
  add_foreign_key "map_connections", "maps"
  add_foreign_key "map_connections", "maps", column: "connected_map_id"
  add_foreign_key "monster_types", "maps"
  add_foreign_key "monsters", "characters", column: "target_id"
  add_foreign_key "monsters", "monster_types"
  add_foreign_key "players", "characters"
  add_foreign_key "players", "users"
end
