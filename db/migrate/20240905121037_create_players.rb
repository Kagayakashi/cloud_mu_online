class CreatePlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :players do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true, name: 'unique_player_user' }
      t.references :character, null: false, foreign_key: true, index: { unique: true, name: 'unique_player_character' }

      t.timestamps
    end
  end
end
