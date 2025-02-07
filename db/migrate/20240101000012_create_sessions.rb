class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
