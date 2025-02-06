class CreateMaps < ActiveRecord::Migration[7.1]
  def change
    create_table :maps do |t|
      t.string :name, null: false, index: { unique: true, name: 'unique_map_name' }
      t.boolean :peace, null: false
      t.integer :min_level, default: 1, null: false

      t.timestamps
    end
  end
end
