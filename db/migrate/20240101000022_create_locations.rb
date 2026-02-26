class CreateLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :locations do |t|
      t.string :name, null: false, index: { unique: true }
      t.integer :level, null: false, default: 1
      t.references :city, foreign_key: { on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end
