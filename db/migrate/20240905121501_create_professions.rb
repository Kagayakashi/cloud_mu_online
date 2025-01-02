class CreateProfessions < ActiveRecord::Migration[7.2]
  def change
    create_table :professions do |t|
      t.string :name, index: { unique: true, name: 'unique_profession_name' }
      t.string :code, index: { unique: true, name: 'unique_profession_code' }
      t.integer :level

      t.timestamps
    end

    add_reference :characters, :profession, null: false, foreign_key: true
  end
end
