class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false, index: { unique: true, name: 'unique_names' }
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
      t.boolean :active, null: false

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end

  def self.down
    remove_reference :characters, :user
    drop_table :characters
  end
end
