class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.string :type, null: false
      t.string :name, null: false, index: { unique: true, name: 'unique_character_name' }
      t.integer :level, null: false, default: 1

      t.integer :health, null: false, default: 1
      t.integer :max_health, null: false, default: 1
      t.integer :mana, null: false, default: 1
      t.integer :max_mana, null: false, default: 1

      t.integer :attack_rate, null: false, default: 1
      t.integer :min_attack, null: false, default: 1
      t.integer :max_attack, null: false, default: 1

      t.integer :defense_rate, null: false, default: 1
      t.integer :defense, null: false, default: 1

      t.integer :strength, null: false, default: 1
      t.integer :agility, null: false, default: 1
      t.integer :vitality, null: false, default: 1
      t.integer :energy, null: false, default: 1

      t.integer :experience, null: false, default: 0
      t.integer :max_experience, null: false, default: 1
      t.integer :points, null: false, default: 0

      t.integer :activity, null: false, default: 10
      t.integer :max_activity, null: false, default: 10
      t.datetime :last_restore_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :last_regeneration_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
