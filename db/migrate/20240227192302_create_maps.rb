class CreateMaps < ActiveRecord::Migration[7.1]
  def change
    create_table :maps do |t|
      t.string :name, null: false
      t.integer :min_level, null: false
      t.integer :teleport_cost, null: false

      t.timestamps
    end
  end
end
