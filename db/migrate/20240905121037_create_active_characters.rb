class CreateActiveCharacters < ActiveRecord::Migration[7.2]
  def change
    create_table :active_characters do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true, name: 'unique_users' }
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
