class AddSpotRefToCharacters < ActiveRecord::Migration[7.1]
  def change
    add_reference :characters, :spot, null: false, foreign_key: true
  end

  def self.down
    remove_reference :characters, :spot
  end
end
