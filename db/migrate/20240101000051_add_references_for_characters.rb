class AddReferencesForCharacters < ActiveRecord::Migration[7.2]
  def change
    add_reference :characters, :map, foreign_key: true, null: false
    add_reference :characters, :location, foreign_key: true
    add_reference :characters, :user, foreign_key: true

    add_reference :users, :character, foreign_key: true
  end
end
