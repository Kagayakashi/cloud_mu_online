class CreatePlayerCharacters < ActiveRecord::Migration[7.2]
  def change
    create_table :player_characters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
