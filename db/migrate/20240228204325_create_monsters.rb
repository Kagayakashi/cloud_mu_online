class CreateMonsters < ActiveRecord::Migration[7.1]
  def change
    create_table :monsters do |t|
      t.integer :health, null: false

      t.references :monster_type, null: false, foreign_key: true
      t.references :map, null: false, foreign_key: true
      t.references :target, foreign_key: { to_table: :characters }

      t.timestamps
    end
  end

  def self.down
    remove_reference :spot_monsters, :monster
    remove_reference :spot_monsters, :spot
    remove_reference :spot_monsters, :target
  end
end
