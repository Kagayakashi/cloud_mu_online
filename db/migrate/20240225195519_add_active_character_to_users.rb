class AddActiveCharacterToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :active_character, foreign_key: { to_table: :characters }
  end
end
