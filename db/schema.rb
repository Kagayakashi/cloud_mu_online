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
    t.string "type", null: false
    t.string "name", null: false
    t.integer "level", default: 1, null: false
    t.integer "health", default: 1, null: false
    t.integer "max_health", default: 1, null: false
    t.integer "mana", default: 1, null: false
    t.integer "max_mana", default: 1, null: false
    t.integer "attack_rate", default: 1, null: false
    t.integer "min_attack", default: 1, null: false
    t.integer "max_attack", default: 1, null: false
    t.integer "defense_rate", default: 1, null: false
    t.integer "defense", default: 1, null: false
    t.integer "strength", default: 1, null: false
    t.integer "agility", default: 1, null: false
    t.integer "vitality", default: 1, null: false
    t.integer "energy", default: 1, null: false
    t.integer "experience", default: 0, null: false
    t.integer "max_experience", default: 1, null: false
    t.integer "points", default: 0, null: false
    t.integer "activity", default: 10, null: false
    t.integer "max_activity", default: 10, null: false
    t.datetime "last_restore_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "last_regeneration_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "map_id", null: false
    t.integer "user_id"
    t.index ["map_id"], name: "index_characters_on_map_id"
    t.index ["name"], name: "unique_character_name", unique: true
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
    t.string "name", null: false
    t.boolean "peace", null: false
    t.integer "min_level", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "unique_map_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "is_guest", default: true, null: false
    t.datetime "last_login_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "character_id"
    t.index ["character_id"], name: "index_users_on_character_id"
    t.index ["email"], name: "unique_user_email", unique: true
    t.index ["username"], name: "unique_user_username", unique: true
  end

  add_foreign_key "characters", "maps"
  add_foreign_key "characters", "users"
  add_foreign_key "game_logs", "characters"
  add_foreign_key "map_connections", "maps"
  add_foreign_key "map_connections", "maps", column: "connected_map_id"
  add_foreign_key "users", "characters"
end
