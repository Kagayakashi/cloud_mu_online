class CreateSpots < ActiveRecord::Migration[7.1]
  def change
    create_table :spots do |t|
      t.string :name
      t.references :map, null: false, foreign_key: true

      t.timestamps
    end
  end

  def self.down
    remove_reference :spots, :map
  end
end
