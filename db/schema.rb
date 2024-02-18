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

ActiveRecord::Schema[7.1].define(version: 2024_02_18_193438) do
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
    t.boolean "active", null: false
    t.bigint "user_id", null: false
    t.string "characterable_type", null: false
    t.bigint "characterable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["characterable_type", "characterable_id"], name: "index_characters_on_characterable"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "characters", "users"
end
