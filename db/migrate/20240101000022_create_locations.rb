class CreateLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :locations do |t|
      t.string :name, null: false, index: { unique: true, name: 'unique_location_name' }
      t.string :code, null: false, index: { unique: true, name: 'unique_location_code' }
      t.boolean :peace, null: false

      t.references :map, null: false

      t.timestamps
    end
  end
end
