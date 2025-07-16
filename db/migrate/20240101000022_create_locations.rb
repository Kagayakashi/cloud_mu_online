class CreateLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :locations do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :code, null: false, index: { unique: true }
      t.boolean :peace, null: false

      t.references :map, foreign_key: { on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end
