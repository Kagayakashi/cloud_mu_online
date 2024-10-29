class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.integer :level, null: false
      t.integer :experience, null: false
      t.integer :points, null: false
      t.integer :current_health, null: false
      t.integer :max_health, null: false
      t.integer :current_mana, null: false
      t.integer :max_mana, null: false
      t.integer :strength, null: false
      t.integer :agility, null: false
      t.integer :vitality, null: false
      t.integer :energy, null: false

      t.integer :gold, null: false
      t.integer :activity, null: false
      t.datetime :last_restore_at, null: false

      t.datetime :last_regeneration_at, null: false

      t.references :user, foreign_key: true, null: false

      t.timestamps
    end

    add_index :characters, :type
  end
end
