class CreateProfessions < ActiveRecord::Migration[7.2]
  def change
    create_table :professions do |t|
      t.string :name
      t.string :code
      t.integer :level

      t.timestamps
    end

    add_reference :characters, :profession, null: false, foreign_key: true
  end
end
