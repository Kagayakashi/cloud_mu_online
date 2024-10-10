class CreateProfessions < ActiveRecord::Migration[7.2]
  def change
    create_table :professions do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.integer :level, null: false
      t.boolean :initial, null: false, default: false

      t.timestamps
    end

    add_reference :characters, :profession, null: false, foreign_key: true
  end
end
