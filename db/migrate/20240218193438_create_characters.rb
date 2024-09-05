class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
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

      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end

  def self.down
    remove_reference :characters, :user
  end
end
