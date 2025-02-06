class CreateMaps < ActiveRecord::Migration[7.1]
  def change
    create_table :maps do |t|
      t.string :name, null: false, index: { unique: true, name: 'unique_map_name' }
      t.string :code, null: false, index: { unique: true, name: 'unique_map_code' }
      t.integer :level, null: false, default: 1

      t.timestamps
    end
  end
end
