class AddSpotRefToCharacters < ActiveRecord::Migration[7.1]
  def change
    add_reference :characters, :spot, null: false, foreign_key: true
  end
end
