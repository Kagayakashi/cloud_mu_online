class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.string :name, null: false, index: { unique: true }
      t.integer :level, null: false, default: 1

      t.timestamps
    end
  end
end
