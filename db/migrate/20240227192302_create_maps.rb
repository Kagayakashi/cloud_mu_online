class CreateMaps < ActiveRecord::Migration[7.1]
  def change
    create_table :maps do |t|
      t.string :code
      t.string :name, null: false
      t.integer :min_level, default: 1, null: false
      t.boolean :can_teleport, default: false, null: false
      t.integer :teleport_cost, default: 1000, null: false
      t.integer :teleport_min_level, default: 1, null: false

      t.timestamps
    end

    add_reference :characters, :map, null: false, foreign_key: true
  end
end
