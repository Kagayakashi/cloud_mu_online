class CreateMonsters < ActiveRecord::Migration[7.1]
  def change
    create_table :monsters do |t|
      t.integer :health, null: false

      t.references :monster_type, null: false, foreign_key: true
      t.references :target, foreign_key: { to_table: :characters }

      t.timestamps
    end
  end
end
