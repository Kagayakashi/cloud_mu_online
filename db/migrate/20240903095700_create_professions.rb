class CreateProfessions < ActiveRecord::Migration[7.2]
  def change
    create_table :professions do |t|
      t.string :name, null: false, index: { unique: true, name: 'unique_names' }
      t.integer :max_level

      t.timestamps
    end

    add_reference :characters, :profession, null: false, foreign_key: true
  end
end
