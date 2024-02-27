class CreateMaps < ActiveRecord::Migration[7.1]
  def change
    create_table :maps do |t|
      t.string :name
      t.integer :min_level
      t.integer :teleport_cost

      t.timestamps
    end
  end
end
