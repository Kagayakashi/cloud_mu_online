class CreateInGameLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :game_logs do |t|
      t.references :character, null: false, foreign_key: true
      t.text :description
      t.string :type

      t.timestamps
    end
  end
end
