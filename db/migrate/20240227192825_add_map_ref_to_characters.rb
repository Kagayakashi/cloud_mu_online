class AddMapRefToCharacters < ActiveRecord::Migration[7.1]
  def change
    add_reference :characters, :map, null: false, foreign_key: true
  end

  def self.down
    remove_reference :characters, :map
  end
end
